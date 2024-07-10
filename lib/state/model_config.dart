import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModelConfigProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  late ModelConfig _currentChatModel;
  String? _currentModel;

  ModelConfig get currentChatModel => _currentChatModel;
  String get currentModel => _currentModel!;

  ModelConfigProvider() {
    _init();
  }

  final defaultModelConfig = ModelConfig(
    maxTokens: 1000,
    temperature: 0.5,
    topP: 1,
    historyMessages: 4,
    autoTitle: false,
  );

  Future<void> _init() async {
    print('======================================');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? configResult = prefs.getString('currentModelConfig');
    if (configResult != null) {
      final Map<String, dynamic> jsonMap = json.decode(configResult);
      _currentChatModel = ModelConfig.fromJson(jsonMap);
    } else {
      _currentChatModel = defaultModelConfig;
    }
    final data = await supabase.rpc('get_all_models');
    Log.d(data);
    // final String? nameResult = prefs.getString('currentModel');

    // // if (nameResult != null) {
    // //   _currentModel = nameResult;
    // // }
    notifyListeners();
  }

  Future<void> update({
    int? maxTokens,
    double? temperature,
    double? topP,
    int? historyMessages,
    bool? autoTitle,
    ModelConfig? newModelConfig,
  }) async {
    if (newModelConfig != null) {
      _currentChatModel = newModelConfig;
    } else {
      _currentChatModel = _currentChatModel.copyWith(
        maxTokens: maxTokens,
        temperature: temperature,
        topP: topP,
        historyMessages: historyMessages,
        autoTitle: autoTitle,
      );
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'currentModelConfig', jsonEncode(_currentChatModel.toJson()));
    notifyListeners();
  }
}
