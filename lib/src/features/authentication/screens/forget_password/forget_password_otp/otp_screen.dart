import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/controllers/otp_controller.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    // this.user,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.fullName,
    required this.collegeName,
    required this.pinCode,
    required this.dateTime,
    required this.date,
    required this.time,
  });

  // final UserModel? user;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String collegeName;
  final String pinCode;
  final String dateTime;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var otpController = Get.put(OTPController());
    UserModel user1 = UserModel(
        email: email,
        password: password,
        phoneNo: phoneNo,
        fullName: fullName,
        collegeName: collegeName,
        pinCode: pinCode,
        dateTime: dateTime,
        date: date,
        time: time);
    var otp;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: height,
          padding: const EdgeInsets.fromLTRB(tDefaultSize - 10,
              tDefaultSize * 6, tDefaultSize - 10, tDefaultSize - 10),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tOtpTitle,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 80.0),
                ),
                Text(tOtpSubTitle.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 40.0),
                Text("$tOtpMessage $phoneNo", textAlign: TextAlign.center),
                const SizedBox(height: 20.0),
                OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.center,
                    numberOfFields: 6,
                    fillColor: Colors.black.withOpacity(0.1),
                    filled: true,
                    onSubmit: (code) {
                      otp = code;
                      OTPController.instance
                          .verifyOTP(otp, email, password, user1);
                    }),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        OTPController.instance
                            .verifyOTP(otp, email, password, user1);
                      },
                      child: const Text(tNext)),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text.rich(TextSpan(
                    text: tWrong,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
