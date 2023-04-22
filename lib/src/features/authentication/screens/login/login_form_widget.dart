import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/controllers/login_controller.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_btn_widget.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final controller_pro = Get.put(ProfileController());
    final _formKey = GlobalKey<FormState>();
    var email_reg = <String>[];
    var phoneNo_reg = <String>[];

    return Container(
      padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: FutureBuilder(
          future: controller_pro.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var itemCount = snapshot.data!.length;
                for (var i = itemCount - 1; i >= 0; i--) {
                  email_reg.add(snapshot.data![i].email);
                  phoneNo_reg.add(snapshot.data![i].phoneNo);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email ID.';
                        } else if (email_reg.contains(value)) {
                          return null;
                        } else {
                          return 'Email ID not exist.';
                        }
                      },
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: tEmail,
                        hintText: tEmail,
                        // border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: tFormHeight - 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Your Password.';
                        }
                        return null;
                      },
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.fingerprint),
                        labelText: tPassword,
                        hintText: tPassword,
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: tFormHeight - 20,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              ForgetPasswordScreen.buildShoeModalBottomSheet(
                                  context);
                            },
                            child: Text(tForgetPassword))),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: controller.email.text,
                                    password: controller.password.text)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            }).onError((error, stackTrace) {
                              {
                                Get.snackbar("Alert", "Incorrect Password.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.1),
                                    colorText: Colors.red);
                                // }
                              }
                            });
                          }
                        },
                        child: Text(tLogin.toUpperCase()),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: Text('Something went Wrong !!!'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
