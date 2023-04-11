import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_btn_widget.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/profile/all_users.dart';
import 'package:dhamni/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:dhamni/src/features/core/screens/profile/widgets/profile_menu.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
          tProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.moon),
          ),
        ],
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
                                LineAwesomeIcons.alternate_pencil,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData.fullName,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        userData.email,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => UpdateProfileScreen()),
                          child: const Text(tEditProfile),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide.none,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                        title: "Setting",
                        icon: LineAwesomeIcons.cog,
                        iconIconColor: tAccentColor,
                        iconCircleColor: tAccentColor,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        title: "Billing Details",
                        icon: LineAwesomeIcons.wallet,
                        iconIconColor: tAccentColor,
                        iconCircleColor: tAccentColor,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        title: "User Management",
                        icon: LineAwesomeIcons.user_check,
                        iconIconColor: tAccentColor,
                        iconCircleColor: tAccentColor,
                        onPress: () => Get.to(() => AllUsers()),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                        title: tResetPassword,
                        iconIconColor: tAccentColor,
                        iconCircleColor: tAccentColor,
                        icon: LineAwesomeIcons.ice_cream,
                        onPress: () {
                          ForgetPasswordScreen.buildShoeModalBottomSheet(
                              context);
                        },
                      ),
                      ProfileMenuWidget(
                        title: "Logout",
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          // LOGOUT BUTTON
                          AuthenticationRepository.instance.logout();
                        },
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
    );
  }
}
