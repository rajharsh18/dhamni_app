import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/chat/chat_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  addRequest(ChatModel chat) async {
    await _db.collection("Chatroom").doc(chat.id).set(chat.toJson());
  }

  Future<ChatModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<ChatModel>> receiverChat(String email) async {
    final snapshot = await _db
        .collection("Chatroom")
        .where("Email1", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<ChatModel>> donorChat(String email) async {
    final snapshot = await _db
        .collection("Chatroom")
        .where("Email1", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<ChatModel>> allChat() async {
    final snapshot = await _db.collection("Chatroom").get();
    final userData =
        snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    return userData;
  }
}
