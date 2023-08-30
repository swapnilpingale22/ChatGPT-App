import 'package:flutter/material.dart';
import 'package:voice_assistant/models/chatmodels_model.dart';

import '../services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ChatModel> modelsList = [];

  List<ChatModel> get getModleList {
    return modelsList;
  }

  Future<List<ChatModel>> getAllModels() async {
    modelsList = await ApiServices.getModels();
    return modelsList;
  }
}
