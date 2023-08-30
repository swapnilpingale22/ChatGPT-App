import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:voice_assistant/models/chat_model.dart';
import 'package:voice_assistant/models/chatmodels_model.dart';
import '../constants/constants.dart';
import '../constants/secrets.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse(modelUrl),
        headers: {"Authorization": "Bearer $apiKey"},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse: $jsonResponse');
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // print(value['id']);
        // print(temp);
      }
      return ModelsModel.modelsList(temp);
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

//Send message using chatGPT model API

  static Future<List<ChatModel>> sendMessageGPT(
      String message, String modelId) async {
    try {
      var response = await http.post(
        Uri.parse(chatGPTUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
          // {
          //   "model": modelId,
          //   "prompt": message,
          //   "max_tokens": 100,
          // },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // print(
        //     'jsonResponse[choices][text] : ${jsonResponse['choices'][0]['text']}');

        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['message']['content'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  //Send messages

  static Future<List<ChatModel>> sendMessage(
      String message, String modelId) async {
    try {
      var response = await http.post(
        Uri.parse(chatUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // print(
        //     'jsonResponse[choices][text] : ${jsonResponse['choices'][0]['text']}');

        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['text'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
