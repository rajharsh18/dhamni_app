import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:dhamni/src/repository/authentication_repository/exception/login_email_password_failure.dart';
import 'package:dhamni/src/repository/authentication_repository/exception/signup_email_password_failure.dart';
import 'package:dhamni/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final userRepo = Get.put(UserRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const Dashboard());
  }

  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided Phone Number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try Again.');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp, UserModel user) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    if (credentials.user != null) {
      await userRepo.createUser(user);
    }
    return credentials.user != null ? true : false;
  }

  String? createUserWithEmailAndPassword(String email, String password) {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      // firebaseUser.value != null
      //     ? Get.offAll(() => const Dashboard())
      //     : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
