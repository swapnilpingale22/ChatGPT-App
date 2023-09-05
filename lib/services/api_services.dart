import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:voice_assistant/models/chat_model.dart';
import 'package:voice_assistant/models/chatmodels_model.dart';
import '../constants/constants.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse(bardModelUrl),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse: $jsonResponse');
      List temp = [];
      for (var value in jsonResponse['models']) {
        temp.add(value);
        // print(value['name']);
        // print(temp);
      }
      return ModelsModel.modelsList(temp);
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  //Send messages with Bard

  static Future<List<ChatModel>> sendMessageBard(String message) async {
    try {
      var response = await http.post(
        Uri.parse(bardUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "prompt": {
              "messages": [
                {
                  "content": message,
                }
              ]
            }
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['candidates'].length > 0) {
        chatList = List.generate(
          jsonResponse["candidates"].length,
          (index) => ChatModel(
            msg: jsonResponse['candidates'][index]['content'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      print('Error in sendMessageBard: $e');
      rethrow;
    }
  }
}
