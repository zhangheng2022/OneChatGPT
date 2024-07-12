import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 该类用于管理 ChatGPT 模型的配置。
/// 它提供对当前模型配置的访问，并允许更新配置。
/// 它还从 Supabase 获取可用模型列表。
class ModelConfigProvider extends ChangeNotifier {
  /// Supabase 客户端实例。
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 当前模型配置。
  ModelConfig _currentModelConfig = ModelConfig(
    maxTokens: 1000,
    temperature: 0.5,
    topP: 1,
    historyMessages: 4,
    autoTitle: false,
  );

  /// 默认模型配置。
  final _defaultModelConfig = ModelConfig(
    maxTokens: 1000,
    temperature: 0.5,
    topP: 1,
    historyMessages: 4,
    autoTitle: false,
  );

  /// 当前选定模型的名称。
  String? _currentModelName;

  /// 可用模型列表。
  List<String> _modelList = [];

  /// 获取当前模型配置。
  ModelConfig get currentModelConfig => _currentModelConfig;

  /// 获取当前选定模型的名称。
  String get currentModelName => _currentModelName!;

  /// 获取可用模型列表。
  List<String> get modelList => _modelList;

  /// ModelConfigProvider 类的构造函数。
  /// 通过调用 _init() 方法初始化类。
  ModelConfigProvider() {
    _init();
  }

  /// 初始化模型配置并获取可用模型列表。
  Future<void> _init() async {
    /// 从 Supabase 获取可用模型列表。
    final data = await _supabase.rpc('select-all-model');
    final List<String> listData = List<String>.from(data['all_models']);
    _modelList = listData;

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 从 SharedPreferences 检索保存的模型配置。
    final String? configResult = prefs.getString('currentModelConfig');

    /// 根据检索到的数据设置当前模型配置。
    /// 如果未找到保存的配置，则使用默认配置。
    if (configResult != null) {
      _currentModelConfig = ModelConfig.fromJson(
          jsonDecode(configResult) as Map<String, dynamic>);
    }

    /// 从 SharedPreferences 检索保存的模型名称。
    final String? nameResult = prefs.getString('currentModel');

    /// 根据检索到的数据设置当前模型名称。
    /// 如果未找到保存的名称，则使用列表中的第一个模型。
    _currentModelName = nameResult ?? _modelList.first;

    /// 通知监听器数据已更改。
    notifyListeners();
  }

  /// 更新模型配置。
  /// 接受可选参数以更新特定配置值。
  /// 如果提供了新的模型配置，则将直接使用它。
  Future<void> updateModelConfig({
    int? maxTokens,
    double? temperature,
    double? topP,
    int? historyMessages,
    bool? autoTitle,
    ModelConfig? newModelConfig,
  }) async {
    /// 根据提供的参数或新的模型配置设置当前模型配置。
    _currentModelConfig = newModelConfig ??
        _currentModelConfig.copyWith(
          maxTokens: maxTokens,
          temperature: temperature,
          topP: topP,
          historyMessages: historyMessages,
          autoTitle: autoTitle,
        );

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 将更新后的模型配置保存到 SharedPreferences。
    await prefs.setString(
        'currentModelConfig', jsonEncode(_currentModelConfig.toJson()));

    /// 通知监听器数据已更改。
    notifyListeners();
  }

  /// 更新模型名称。
  /// 接受新的模型名称作为参数。
  Future<void> updateModelName(String newModelName) async {
    /// 设置当前模型名称为新名称。
    _currentModelName = newModelName;
    print(newModelName);

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 将更新后的模型名称保存到 SharedPreferences。
    await prefs.setString('currentModel', newModelName);

    /// 通知监听器数据已更改。
    notifyListeners();
  }
}
