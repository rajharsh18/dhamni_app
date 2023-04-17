import 'package:dhamni/src/features/authentication/controllers/signup_controllers.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:dhamni/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(
      String otp, String email, String password, UserModel user) async {
    var isVerified =
        await AuthenticationRepository.instance.verifyOTP(otp, user);
    isVerified ? saveAuthenticationData(email, password) : Get.back();
  }

  final userRepo = Get.put(UserRepository());

  void saveAuthenticationData(String email, String password) async {
    await SignUpController.instance.registerUser(email, password);
    Get.snackbar("Alert", "Please Reset your password using your Email-ID.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orangeAccent.withOpacity(0.1),
        colorText: Colors.orange);
    Get.offAll(() => const Dashboard());
  }
}
