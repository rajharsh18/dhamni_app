import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // const Text("OR"),
      SizedBox(
        height: tFormHeight - 20.0,
      ),
      // SizedBox(
      //   width: double.infinity,
      //   child: OutlinedButton.icon(
      //       icon: Image(
      //         image: AssetImage(tGoogleLogoImage),
      //         width: 20.0,
      //       ),
      //       onPressed: () {},
      //       label: Text(tSignInWithGoogle)),
      // ),
      TextButton(
        onPressed: () => Get.to(() => LoginScreen()),
        child: const Text.rich(TextSpan(
            text: tAlreadyHaveAnAccount, children: [TextSpan(text: tLogin)])),
      ),
    ]);
  }
}
