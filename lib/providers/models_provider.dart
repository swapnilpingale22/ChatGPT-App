import 'package:flutter/material.dart';
import 'package:voice_assistant/models/chatmodels_model.dart';
import '../services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "models/chat-bison-001";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModleList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiServices.getModels();
    return modelsList;
  }
}
