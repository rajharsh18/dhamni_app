import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:dhamni/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  Future<void> createUser(UserModel user) async {
    phoneAuthentication(user.phoneNo);
    Get.snackbar("Alert", "Please enter your OTP.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orangeAccent.withOpacity(0.1),
        colorText: Colors.orange);
    Get.to(() => OTPScreen(
        email: user.email,
        password: user.password,
        phoneNo: user.phoneNo,
        fullName: user.fullName,
        collegeName: user.collegeName,
        pinCode: user.pinCode,
        dateTime: user.dateTime,
        date: user.date,
        time: user.time));
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
