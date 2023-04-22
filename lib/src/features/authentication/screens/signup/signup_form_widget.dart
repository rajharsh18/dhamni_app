import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhamni/src/common_widgets/phone_input_formatter.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/controllers/signup_controllers.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference buttonPressCollection =
        FirebaseFirestore.instance.collection('Users');
    final PhoneInputFormatter _phoneFormatter = PhoneInputFormatter();
    final controller_pro = Get.put(ProfileController());
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    const password = "password";
    const collegeName = "Select College Name";
    var email_reg = <String>[];
    var phoneNo_reg = <String>[];
    var currentDate = '';
    var currentTime = '';
    var bloodGroup = "Select Blood Group";

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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          labelText: tFullName,
                          hintText: tFullName,
                          // border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 20),
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: tEmail,
                          hintText: tEmail,
                          // border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 20),
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
                        keyboardType: TextInputType.phone,
                        inputFormatters: [_phoneFormatter],
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          labelText: tPhoneNo,
                          hintText: tPhoneNo,
                          // border: OutlineInputBorder(),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      // const SizedBox(height: tFormHeight - 20),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter Password.';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   controller: controller.password,
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(Icons.password_outlined),
                      //     labelText: tPassword,
                      //     hintText: tPassword,
                      //     // border: OutlineInputBorder(),
                      //   ),
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      const SizedBox(height: tFormHeight - 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              DateTime now = DateTime.now();
                              String currentDate =
                                  DateFormat('dd MMMM yyyy').format(now);
                              String currentTime =
                                  DateFormat('HH:mm:ss').format(now);
                              final user = UserModel(
                                email: controller.email.text.trim(),
                                // password: controller.password.text.trim(),
                                password: password,
                                phoneNo: controller.phoneNo.text.trim(),
                                fullName: controller.fullName.text.trim(),
                                collegeName: collegeName,
                                pinCode: "",
                                dateTime: now.toString().trim(),
                                date: currentDate,
                                time: currentTime,
                                bloodGroup: bloodGroup,
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
