import 'package:flutter/material.dart';
import 'package:voice_assistant/services/api_services.dart';
import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  final List messages = [];

  List get getChatList {
    return messages;
  }

  void addUserMessage({required String msg}) {
    messages.add(
      ChatModel(
        content: msg,
        author: 0,
      ),
    );

    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({required String msg}) async {
    String responseMessage = await ApiServices.sendMessageBard(msg);

    messages.add(
      ChatModel(
        content: responseMessage,
        author: 1,
      ),
    );

    notifyListeners();
  }
}
