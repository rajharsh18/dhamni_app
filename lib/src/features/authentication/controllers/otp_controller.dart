import 'package:dhamni/src/features/authentication/controllers/signup_controllers.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:dhamni/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp, String email, String password) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? saveAuthenticationData(email, password) : Get.back();
  }

  final userRepo = Get.put(UserRepository());

  void saveAuthenticationData(String email, String password) {
    Get.snackbar("Success", "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.greenAccent.withOpacity(0.1),
        colorText: Colors.green);
    Get.snackbar("Alert", "Please Reset your password using your Email-ID.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withOpacity(0.1),
        colorText: Colors.orange);
    SignUpController.instance.registerUser(email, password);
  }
}
