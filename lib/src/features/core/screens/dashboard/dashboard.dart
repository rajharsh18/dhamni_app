import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/blood_forms/all_request.dart';
import 'package:dhamni/src/features/blood_forms/all_request_blood_group.dart';
import 'package:dhamni/src/features/blood_forms/all_request_college.dart';
import 'package:dhamni/src/features/blood_forms/all_request_pincode.dart';
import 'package:dhamni/src/features/blood_forms/blood_request_form.dart';
import 'package:dhamni/src/features/chat/donor_chat.dart';
import 'package:dhamni/src/features/chat/receiver_chat.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/profile/profile_screen.dart';
import 'package:dhamni/src/features/core/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final txtTheme = Theme.of(context).textTheme;
    final controller = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // leading: Icon(
          //   Icons.menu,
          //   //For Dark Color
          //   color: isDark ? tWhiteColor : tDarkColor,
          // ),
          title:
              Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //For Dark Color
                // color: isDark ? tSecondaryColor : tCardBgColor,
                color: tCardBgColor,
              ),
              child: IconButton(
                  onPressed: () => Get.to(() => ProfileScreen()),
                  icon: const Image(image: AssetImage(tUserProfileImage))),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.fullName,
                          style: txtTheme.headlineMedium,
                        ),
                        Text(
                          userData.collegeName,
                          style: txtTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: tDashboardPadding,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: [
                              ProfileMenuWidget(
                                title: tAsk,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: LineAwesomeIcons.plus_circle,
                                onPress: () => Get.to(() => Blood_request()),
                              ),
                              Divider(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tDemanded,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: LineAwesomeIcons.alternate_file,
                                onPress: () => Get.to(() => AllRequest()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tDemandedCollege,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: Icons.school_outlined,
                                onPress: () =>
                                    Get.to(() => AllRequestCollege()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tDemandedPinCode,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: Icons.map_outlined,
                                onPress: () =>
                                    Get.to(() => AllRequestPincode()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tDemandedBloogGroup,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: Icons.bloodtype_outlined,
                                onPress: () =>
                                    Get.to(() => AllRequestBloodGroup()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tDonating,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: Icons.chat_bubble_outline_outlined,
                                onPress: () => Get.to(() => DonorChat()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ProfileMenuWidget(
                                title: tRequestChat,
                                tileColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                iconIconColor: tAccentColor,
                                iconCircleColor:
                                    Color.fromARGB(255, 7, 78, 136),
                                endIconColor: Colors.grey,
                                endCircleColor: Colors.grey,
                                icon: Icons.chat_bubble_outline_rounded,
                                onPress: () => Get.to(() => ReceiverChat()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
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
          ),
        ),
      ),
    );
  }
}
