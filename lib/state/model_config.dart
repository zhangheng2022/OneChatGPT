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
  late String _currentModel;
  late String _currentProvider;

  /// 可用模型列表。
  late List<ChannelModel> _channelModels;

  /// 获取当前模型配置。
  ModelConfig get currentModelConfig => _currentModelConfig;

  /// 获取当前模型。
  String get currentModel => _currentModel;
  String get currentProvider => _currentProvider;

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
    /// 从 Supabase 获取可用模型列表。
    List<dynamic> data = await _supabase.rpc('get_model_config');
    _channelModels = data.map((item) => ChannelModel.fromJson(item)).toList();

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{
          'currentModelConfig',
          'currentModel',
          'currentProvider'
        },
      ),
    );

    /// 从 SharedPreferences 检索保存的模型配置。
    String? configResult = prefsWithCache.getString('currentModelConfig');

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

    final String? modelResult = prefsWithCache.getString('currentModel');
    final String? providerResult = prefsWithCache.getString('currentProvider');
    _currentModel = modelResult ?? _channelModels.first.models.first;
    _currentProvider = providerResult ?? _channelModels.first.provider;

    /// 通知监听器数据已更改。
    notifyListeners();
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
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    /// 将更新后的模型配置保存到 SharedPreferences。
    asyncPrefs.setString(
        'currentModelConfig', jsonEncode(_currentModelConfig.toJson()));

    /// 通知监听器数据已更改。
    notifyListeners();
  }

  Future<void> updateModel(
      {required String model, required String provider}) async {
    _currentModel = model;
    _currentProvider = provider;

    /// 获取 SharedPreferences 实例以存储和检索数据。
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    asyncPrefs.setString('currentModel', model);
    asyncPrefs.setString('currentProvider', provider);

    /// 通知监听器数据已更改。
    notifyListeners();
  }

  Future<void> reset() async {
    /// 删除模型配置
    _currentModelConfig = ModelConfig(
      maxTokens: 1000,
      temperature: 0.5,
      topP: 1,
      historyMessages: 4,
      autoTitle: false,
    );
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.remove("currentModelConfig");

    /// 删除模型名称
    _currentModel = _channelModels.first.models.first;
    _currentProvider = _channelModels.first.provider;
    await asyncPrefs.remove("currentModel");

    notifyListeners();
  }
}
