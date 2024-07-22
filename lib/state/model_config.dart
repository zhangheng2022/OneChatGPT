import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:one_chatgpt_flutter/models/response/channel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 该类用于管理 ChatGPT 模型的配置。
/// 它提供对当前模型配置的访问，并允许更新配置。
/// 它还从 Supabase 获取可用模型列表。
class ModelConfigProvider extends ChangeNotifier {
  /// Supabase 客户端实例。
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 当前模型配置。
  late ModelConfig _currentModelConfig;

  /// 当前模型。
  late ChannelModel _currentModel;

  /// 可用模型列表。
  late List<ChannelModel> _channelModels;

  /// 获取当前模型配置。
  ModelConfig get currentModelConfig => _currentModelConfig;

  /// 获取当前模型。
  ChannelModel get currentModel => _currentModel;

  /// 获取可用模型列表。
  List<ChannelModel> get channelModels => _channelModels;

  /// ModelConfigProvider 类的构造函数。
  /// 通过调用 _init() 方法初始化类。
  ModelConfigProvider() {
    Log.t("ModelConfigProvider初始化");
    _init();
  }

  /// 初始化模型配置并获取可用模型列表。
  Future<void> _init() async {
    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      /// 从 Supabase 获取可用模型列表。
      final data = await _supabase.rpc('get_channels');
      final List<ChannelModel> oneapiData = (data['result'] as List<dynamic>)
          .map((item) => ChannelModel.fromJson(item))
          .toList();
      _channelModels = oneapiData;

      /// 从 SharedPreferences 检索保存的模型配置。
      final String? configResult = prefs.getString('currentModelConfig');

      /// 根据检索到的数据设置当前模型配置。
      /// 如果未找到保存的配置，则使用默认配置。
      if (configResult != null) {
        _currentModelConfig = ModelConfig.fromJson(jsonDecode(configResult));
      } else {
        _currentModelConfig = ModelConfig(
          maxTokens: 1000,
          temperature: 0.5,
          topP: 1,
          historyMessages: 4,
          autoTitle: false,
        );
      }

      final String? modelResult = prefs.getString('currentModel');
      if (modelResult != null) {
        _currentModel = ChannelModel.fromJson(jsonDecode(modelResult));
      } else {
        _currentModel = _channelModels.first;
      }

      /// 通知监听器数据已更改。
      notifyListeners();
    } catch (e) {
      Log.e(e);
    }
  }

  /// 更新模型配置。
  /// 接受可选参数以更新特定配置值。
  /// 如果提供了新的模型配置，则将直接使用它。
  Future<void> updateModelConfig({
    String? model,
    int? maxTokens,
    double? temperature,
    double? topP,
    double? historyMessages,
    bool? autoTitle,
    ModelConfig? newModelConfig,
  }) async {
    /// 根据提供的参数或新的模型配置设置当前模型配置。
    _currentModelConfig = newModelConfig ??
        _currentModelConfig.copyWith(
          model: model,
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

  Future<void> updateModel({required String model}) async {
    _currentModel = _channelModels.firstWhere((data) => data.model == model);

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentModel', jsonEncode(_currentModel.toJson()));

    /// 通知监听器数据已更改。
    notifyListeners();
  }

  Future<void> reset() async {
    _currentModelConfig = ModelConfig(
      maxTokens: 1000,
      temperature: 0.5,
      topP: 1,
      historyMessages: 4,
      autoTitle: false,
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("currentModelConfig");

    _currentModel = _channelModels.first;
    await prefs.remove("currentModel");

    notifyListeners();
  }
}
