class ChatModel {
  final String content;
  final int author;

  ChatModel({
    required this.content,
    required this.author,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        content: json["content"],
        author: json["author"],
      );
}
