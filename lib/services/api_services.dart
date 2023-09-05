import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:voice_assistant/models/chat_model.dart';
import 'package:voice_assistant/models/chatmodels_model.dart';
import '../constants/constants.dart';

class ApiServices {
  static final List<Map<String, String>> messages = [];

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

  static Future<String> sendMessageBard(String message) async {
    messages.add({
      'author': '0',
      'content': message,
    });

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
                  "author": "0",
                  "content": message,
                }
              ]
            }
          },
        ),
      );
      // print(response.body);

      if (response.statusCode == 200) {
        // print('API working');
        String content = jsonDecode(response.body)['candidates'][0]['content'];
        content = content.trim();

        messages.add({
          'author': '1',
          'content': content,
        });
        // print('content: ${content}');
        return content;
      }
      String content = jsonDecode(response.body)['error']['message'];

      return content;
    } catch (e) {
      print('Error in sendMessageBard: $e');
      return e.toString();
    }
  }
}
