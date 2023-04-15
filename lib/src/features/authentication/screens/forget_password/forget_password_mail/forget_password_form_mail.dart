import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordMailForm extends StatefulWidget {
  const ForgetPasswordMailForm({Key? key}) : super(key: key);

  @override
  _ForgetPasswordMailFormState createState() => _ForgetPasswordMailFormState();
}

class _ForgetPasswordMailFormState extends State<ForgetPasswordMailForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailTextController = TextEditingController();
    final controller = Get.put(ProfileController());
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final email = TextEditingController(text: user.email);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: email,
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: tEmail,
                            hintText: tEmail,
                            border: OutlineInputBorder()),
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: tFormHeight - 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email.text)
                                    .then(
                                        (value) => Navigator.of(context).pop())
                                    .whenComplete(
                                      () => Get.snackbar("Success",
                                          "Mail has been sent to reset your password",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              Colors.green.withOpacity(0.1),
                                          colorText: Colors.green),
                                    );
                              },
                              child: Text(tNext.toUpperCase()))),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text('Sonething went Wrong !!!'));
                }
              } else {
                return Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _emailTextController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: tEmail,
                              hintText: tEmail,
                              border: OutlineInputBorder()),
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: tFormHeight - 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _emailTextController.text)
                                      .then((value) =>
                                          Navigator.of(context).pop())
                                      .whenComplete(
                                        () => Get.snackbar("Success",
                                            "Mail has been sent to reset your password",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.green.withOpacity(0.1),
                                            colorText: Colors.green),
                                      );
                                },
                                child: Text(tNext.toUpperCase()))),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
