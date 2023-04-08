import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  late String country_id;
  final _country = [
    "America",
    "Brazil",
    "Canada",
    "India",
    "Mongalia",
    "USA",
    "China",
    "Russia",
    "Germany"
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image: AssetImage(tUserProfileImage),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            child: Icon(
                              LineAwesomeIcons.camera,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 20.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: userData.fullName,
                            decoration: const InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(Icons.person_outline_rounded)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            initialValue: userData.email,
                            decoration: const InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(Icons.email_outlined)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            initialValue: userData.phoneNo,
                            decoration: const InputDecoration(
                                label: Text(tPhoneNo),
                                prefixIcon: Icon(Icons.numbers)),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          DropdownButtonFormField(
                            // value: userData.collegeName,
                            decoration: const InputDecoration(
                                label: Text(tCollegeName),
                                prefixIcon: Icon(Icons.add_home_rounded)),
                            items: _country
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (dynamic value) {
                              country_id = value;
                            },
                          ),
                          // const SizedBox(height: tFormHeight - 20),
                          // TextFormField(
                          //   initialValue: userData.password,
                          //   decoration: const InputDecoration(
                          //       label: Text(tPassword),
                          //       prefixIcon: Icon(Icons.fingerprint)),
                          // ),
                          const SizedBox(height: tFormHeight - 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Get.to(() => UpdateProfileScreen()),
                              child: const Text(tEditProfile),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide.none,
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: tFormHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: tJoined,
                                  style: TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text: tJoinedAt,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text(tDelete))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: Text('Sonething went Wrong !!!'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
