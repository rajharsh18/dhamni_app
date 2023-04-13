import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/controllers/signup_controllers.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller_pro = Get.put(ProfileController());
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    const password = "password";
    const collegeName = "Select College Name";
    const pinCode = "";
    var email_reg = <String>[];
    var phoneNo_reg = <String>[];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
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
                  ;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Your Name.';
                          }
                          return null;
                        },
                        controller: controller.fullName,
                        decoration: const InputDecoration(
                            label: Text(tFullName),
                            prefixIcon: Icon(Icons.person_outline_rounded)),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email ID.';
                          } else if (email_reg.contains(value)) {
                            return 'Email ID already registered.';
                          }
                          return null;
                        },
                        controller: controller.email,
                        decoration: const InputDecoration(
                            label: Text(tEmail),
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone Number.';
                          } else if (phoneNo_reg.contains(value)) {
                            return 'Phone Number already registered.';
                          }
                          return null;
                        },
                        controller: controller.phoneNo,
                        decoration: const InputDecoration(
                            label: Text(tPhoneNo),
                            prefixIcon: Icon(Icons.numbers)),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final user = UserModel(
                                email: controller.email.text.trim(),
                                password: password,
                                phoneNo: controller.phoneNo.text.trim(),
                                fullName: controller.fullName.text.trim(),
                                collegeName: collegeName,
                                pinCode: pinCode,
                              );
                              SignUpController.instance.createUser(user);
                            }
                          },
                          child: Text(tSignup.toUpperCase()),
                        ),
                      )
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
            }),
      ),
    );
  }
}
