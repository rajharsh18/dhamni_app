import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final String email1;
  final String email2;
  final String user1;
  final String user2;

  const ChatModel({
    required this.id,
    required this.email1,
    required this.email2,
    required this.user1,
    required this.user2,
  });

  toJson() {
    return {
      "Email1": email1,
      "Email2": email2,
      "User1": user1,
      "User2": user2,
    };
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatModel(
      id: document.id,
      email1: data["Email1"],
      email2: data["Email2"],
      user1: data["User1"],
      user2: data["User2"],
    );
  }
}
