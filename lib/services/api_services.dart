import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../constants/secrets.dart';

class ApiServices {
  static Future<void> getModels() async {
    try {
      var response = await http.get(
        Uri.parse(modelUrl),
        headers: {"Authorization": "Bearer $apiKey"},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      print('jsonResponse: $jsonResponse');
    } catch (e) {
      print('error: $e');
    }
  }
}
