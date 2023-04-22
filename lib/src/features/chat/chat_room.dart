import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChatRoom extends StatelessWidget {
  final String chatRoomId;
  final String sender;
  final String receiver;

  ChatRoom({
    required this.chatRoomId,
    required this.sender,
    required this.receiver,
  });

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": sender,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('Chatroom')
          .doc(chatRoomId)
          .collection('Chats')
          .add(messages);
    } else {
      Get.snackbar("Alert", "Enter Some Text.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      // print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          receiver,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Chatroom')
                    .doc(chatRoomId)
                    .collection('Chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              child: _chatInput(context, 10, _message, onSendMessage),
            )
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == sender
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Text(
                map['message'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container();
  }
}

Widget _chatInput(BuildContext context, double size, message, onSendMessage) {
  return Padding(
    padding: EdgeInsets.all(size),
    child: Row(
      children: [
        //input field & buttons
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),

        //send message button
        MaterialButton(
          onPressed: onSendMessage,
          minWidth: 0,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          shape: const CircleBorder(),
          color: Colors.green,
          child: const Icon(Icons.send, color: Colors.white, size: 28),
        )
      ],
    ),
  );
}
