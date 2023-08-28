import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:voice_assistant/models/chatmodels_model.dart';
import '../constants/constants.dart';
import '../constants/secrets.dart';

class ApiServices {
  static Future<List<ChatModel>> getModels() async {
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
      return ChatModel.modelsList(temp);
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
