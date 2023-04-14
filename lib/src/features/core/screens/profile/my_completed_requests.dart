import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_request_controller.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MyCompletedRequests extends StatelessWidget {
  const MyCompletedRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller_pro = Get.put(ProfileController());
    final controller = Get.put(BloodController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: Text(
            tMyCompletedRequest,
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
                    return FutureBuilder<List<BloodModel>>(
                      future: controller.getUserRequestCompleted(email_user),
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
                                            // Text(
                                            //   "${snapshot.data![index].date}, ${snapshot.data![index].time}",
                                            //   style: TextStyle(fontSize: 10),
                                            //   textAlign: TextAlign.end,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
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
                    return Center(child: Text('Something went Wrong !!!'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
