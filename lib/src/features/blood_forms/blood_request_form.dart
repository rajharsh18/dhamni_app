import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhamni/src/common_widgets/phone_input_formatter.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_request_controller.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Blood_request extends StatelessWidget {
  Blood_request({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Blood_requests');
    final PhoneInputFormatter _phoneFormatter = PhoneInputFormatter();
    final controller = Get.put(BloodController());
    final controller_pro = Get.put(ProfileController());
    final _formKey = GlobalKey<FormState>();
    late String blood_id = "Select Blood Group";
    var college = "";
    var status = "No";
    var email = "";
    var pin = "";
    var currentDate = '';
    var currentTime = '';
    final _blood = [
      "Select Blood Group",
      "A+",
      "A-",
      "B+",
      "B-",
      "AB+",
      "AB-",
      "O+",
      "O-",
      "Others"
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: Text(
            tBloodForm,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: FutureBuilder(
              future: controller_pro.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                    college = user.collegeName;
                    email = user.email;
                    pin = user.pinCode;
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Patient Name.';
                              }
                              return null;
                            },
                            controller: controller.fullName,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_rounded),
                              labelText: tPatientName,
                              hintText: tPatientName,
                              // border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == "Select Blood Group") {
                                return "Please select the Required Blood.";
                              }
                              return null;
                            },
                            value: blood_id,
                            itemHeight: null,
                            isExpanded: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.home_rounded),
                              labelText: tBloodGroup,
                              hintText: tBloodGroup,
                              // border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            items: _blood
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              blood_id = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the No of units required.";
                              }
                              return null;
                            },
                            controller: controller.noUnit,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers),
                              labelText: tReqUnit,
                              hintText: tReqUnit,
                              // border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the Patient's Mobile Number.";
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
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the Pin Code.";
                              }
                              return null;
                            },
                            controller: controller.pinCode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers_outlined),
                              labelText: tPinCode,
                              hintText: tPinCode,
                              // border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (college == "Select College Name" ||
                                    pin == "") {
                                  Get.snackbar("Error",
                                      "Please Update your College and PinCode in the Profile Menu.",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      colorText: Colors.red);
                                } else if (_formKey.currentState!.validate()) {
                                  DateTime now = DateTime.now();
                                  final reqblood = BloodModel(
                                    fullName: controller.fullName.text.trim(),
                                    reqBlood: blood_id,
                                    noUnit: controller.noUnit.text.trim(),
                                    phoneNo: controller.phoneNo.text.trim(),
                                    pinCode: controller.pinCode.text.trim(),
                                    college: college,
                                    status: status,
                                    email: email,
                                    dateTime: now.toString().trim(),
                                  );
                                  BloodController.instance.addRequest(reqblood);
                                  Get.offAll(const Dashboard());
                                }
                              },
                              child: Text(tSubmit.toUpperCase()),
                            ),
                          )
                        ],
                      ),
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
        ),
      ),
    );
  }
}
