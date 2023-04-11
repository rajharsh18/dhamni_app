import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_donate_controller.dart';
import 'package:dhamni/src/features/core/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BloodDonate extends StatelessWidget {
  BloodDonate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BloodController());
    final _formKey = GlobalKey<FormState>();
    late String blood_id = "Select Blood Group";
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
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Form(
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
                    decoration: const InputDecoration(
                      label: Text(tPatientName),
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == "Select Blood Group") {
                        return "Please enter the Required Blood.";
                      }
                      return null;
                    },
                    value: blood_id,
                    itemHeight: null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                        label: Text(tBloodGroup),
                        prefixIcon: Icon(Icons.home_rounded)),
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
                    decoration: const InputDecoration(
                      label: Text(tReqUnit),
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Patient's Mobile Number.";
                      }
                      return null;
                    },
                    controller: controller.phoneNo,
                    decoration: const InputDecoration(
                      label: Text(tPhoneNo),
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Pin Code.";
                      }
                      return null;
                    },
                    controller: controller.pinCode,
                    decoration: const InputDecoration(
                      label: Text(tPinCode),
                      prefixIcon: Icon(Icons.numbers_outlined),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final reqblood = BloodModel(
                            fullName: controller.fullName.text.trim(),
                            reqBlood: blood_id,
                            noUnit: controller.noUnit.text.trim(),
                            phoneNo: controller.phoneNo.text.trim(),
                            pinCode: controller.pinCode.text.trim(),
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
            ),
          ),
        ),
      ),
    );
  }
}
