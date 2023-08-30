import 'package:flutter/material.dart';
import 'package:voice_assistant/services/api_services.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String choosenModel}) async {
    if (choosenModel.toLowerCase().startsWith("gpt")) {
      chatList.addAll(
        await ApiServices.sendMessageGPT(msg, choosenModel),
      );
    } else {
      chatList.addAll(
        await ApiServices.sendMessage(msg, choosenModel),
      );
    }
    notifyListeners();
  }
}
