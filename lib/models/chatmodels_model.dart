class ChatModel {
  final String id;
  final int created;
  final String root;

  ChatModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        created: json['created'],
        root: json['root'],
      );

  static List<ChatModel> modelsList(List modelSnapshot) {
    return modelSnapshot.map((data) => ChatModel.fromJson(data)).toList();
  }
}
