import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_request_controller.dart';
import 'package:dhamni/src/features/chat/chat_controller.dart';
import 'package:dhamni/src/features/chat/chat_modal.dart';
import 'package:dhamni/src/features/chat/chat_room.dart.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AllRequestCollege extends StatefulWidget {
  @override
  _AllRequestCollegeState createState() => _AllRequestCollegeState();
}

class _AllRequestCollegeState extends State<AllRequestCollege>
    with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  @override
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller_pro = Get.put(ProfileController());
    final controller = Get.put(BloodController());
    final controller_chat = Get.put(ChatController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tDemandedCollege,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller_pro.getUserData(),
            builder: (con, snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasData) {
                  UserModel user = snap.data as UserModel;
                  final email_user = user.email;
                  final name_user = user.fullName;
                  final coll_user = user.collegeName;
                  return FutureBuilder<List<BloodModel>>(
                    future: controller.getCollegeRequest(coll_user, email_user),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (c, index) {
                              return Column(
                                children: [
                                  Card(
                                    elevation: 5,
                                    child: ListTile(
                                      iconColor: Colors.blue,
                                      tileColor: Colors.blue.withOpacity(0.1),
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blue.withOpacity(0.1),
                                        ),
                                        child: Icon(LineAwesomeIcons.user_1),
                                      ),
                                      title: Text(
                                          "Patient's Name: ${snapshot.data![index].fullName}"),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                              "Required Blood Group: ${snapshot.data![index].reqBlood}"),
                                          Text(
                                              "No. of unit required: ${snapshot.data![index].noUnit}"),
                                          Text(
                                              "Phone Number: ${snapshot.data![index].phoneNo}"),
                                          Text(
                                              "PinCode: ${snapshot.data![index].pinCode}"),
                                          Text(
                                            "${snapshot.data![index].date}, ${snapshot.data![index].time}",
                                            style: TextStyle(fontSize: 10),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        String roomId = chatRoomId(email_user,
                                            snapshot.data![index].email);
                                        roomId =
                                            "$roomId${snapshot.data![index].fullName}";
                                        ChatModel chat = ChatModel(
                                            id: roomId,
                                            email1: email_user,
                                            email2: snapshot.data![index].email,
                                            user1: name_user,
                                            user2: snapshot
                                                .data![index].fullName2);
                                        await ChatController.instance
                                            .addRequest(chat);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ChatRoom(
                                              chatRoomId: roomId,
                                              sender: name_user,
                                              receiver: snapshot
                                                  .data![index].fullName2,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(tRespond),
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide.none,
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: StadiumBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return Center(
                              child: Text('Something went Wrong !!!'));
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else if (snap.hasError) {
                  return Center(child: Text(snap.error.toString()));
                } else {
                  return Center(child: Text('Sonething went Wrong !!!'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
