import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/features/authentication/screens/login/login_screen.dart';
import 'package:dhamni/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: const Text("Dhamni")),
        body: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                  image: AssetImage(tWelcomeScreenImage), height: height * 0.5),
              Column(children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ]),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () => Get.to(() => LoginScreen()),
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                              foregroundColor: tRedColor,
                              side: BorderSide(color: tSecondaryColor),
                              padding: EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: Text(tLogin.toUpperCase()))),
                  const SizedBox(width: 10.0),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => SignUpScreen()),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                              foregroundColor: tWhiteColor,
                              backgroundColor: tRedColor,
                              side: BorderSide(color: tSecondaryColor),
                              padding: EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: Text(tSignup.toUpperCase()))),
                ],
              )
            ],
          ),
        ));
  }
}
