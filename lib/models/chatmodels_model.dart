class ModelsModel {
  final String name;
  final String displayName;

  ModelsModel({
    required this.name,
    required this.displayName,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        name: json['name'],
        displayName: json['displayName'],
      );

  static List<ModelsModel> modelsList(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
