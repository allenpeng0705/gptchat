import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Message {
  final String id;
  final String text;
  final DateTime createdAt;
  final types.User user;

  Message({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      user: types.User(id: json['userId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'userId': user.id,
    };
  }
}
