import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_request_controller.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:dhamni/src/features/core/screens/profile/my_active_requests.dart';
import 'package:dhamni/src/features/core/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RequestStatus extends StatelessWidget {
  const RequestStatus({
    super.key,
    required this.bloodData,
  });

  final BloodModel bloodData;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final controller = Get.put(BloodController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tBlood,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: FutureBuilder(
          future: controller.getAllRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            readOnly: true,
                            initialValue: bloodData.fullName,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(Icons.person_outline_rounded)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: bloodData.reqBlood,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tBloodGroup),
                                prefixIcon: Icon(Icons.email_outlined)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: bloodData.noUnit,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tReqUnit),
                                prefixIcon: Icon(Icons.numbers)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: bloodData.phoneNo,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tPhoneNo),
                                prefixIcon: Icon(Icons.numbers_outlined)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          TextFormField(
                            readOnly: true,
                            initialValue: bloodData.pinCode,
                            minLines: null,
                            maxLines: null,
                            decoration: const InputDecoration(
                                label: Text(tPinCode),
                                prefixIcon: Icon(Icons.numbers_outlined)),
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: tFormHeight - 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.UpdateBloodRecord(bloodData);
                                Get.snackbar("Success", "Record Updated.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.1),
                                    colorText: Colors.green);
                                Get.offAll(() => const Dashboard());
                              },
                              child: const Text("Request Fullfilled"),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide.none,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: StadiumBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: tFormHeight),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Center(child: Text('Sonething went Wrong !!!'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
