import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_mail/forget_header_widget_mail.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_form_phone.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                SizedBox(height: tDefaultSize * 4),
                ForgetHeaderWidget(size: size),
                SizedBox(
                  height: tFormHeight,
                ),
                ForgetPasswordPhoneForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
