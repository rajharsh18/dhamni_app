import 'package:dhamni/src/features/authentication/controllers/signup_controllers.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:dhamni/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp, String email, String password) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? saveAuthenticationData(email, password) : Get.back();
  }

  final userRepo = Get.put(UserRepository());

  // Call this Function from Design & it will do the rest

  void saveAuthenticationData(String email, String password) {
    SignUpController.instance.registerUser(email, password);
    Get.offAll(const Dashboard());
  }
}
