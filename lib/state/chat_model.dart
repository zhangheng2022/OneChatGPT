import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatModelProvider extends ChangeNotifier {
  ChatModel? _currentChatModel;

  ChatModel get currentChatModel => _currentChatModel!;

  final List<ChatModel> chatModelData = [
    ChatModel(
      fullName: "Google genmini-1.5-pro",
      source: "Google",
      model: 'genmini-1.5-pro',
      maxTokens: 1000,
      temperature: 0.5,
      topP: 1,
      historyMessages: 4,
      autoTitle: false,
    ),
  ];

  ChatModelProvider() {
    _initializeCurrentChatModel();
  }

  Future<void> _initializeCurrentChatModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? sharedModel = prefs.getString('currentChatModel');
    _currentChatModel = chatModelData.firstWhere(
      (element) => element.fullName == sharedModel,
      orElse: () => chatModelData.first,
    );
    notifyListeners();
  }

  update(String fullName) {
    notifyListeners();
  }
}
