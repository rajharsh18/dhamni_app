import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/features/authentication/screens/signup/signup_footer_widget.dart';
import 'package:dhamni/src/features/authentication/screens/signup/signup_form_widget.dart';
import 'package:dhamni/src/features/authentication/screens/signup/signup_header_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupHeaderWidget(size: size),
                const SignUpForm(),
                const SignupFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
