import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRepository extends GetxController {
  static BloodRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  addRequest(BloodModel reqblood) async {
    await _db
        .collection("Blood_requests")
        .add(reqblood.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your Request is Raised.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor:
                  Color.fromARGB(255, 82, 255, 94).withOpacity(0.1),
              colorText: Color.fromARGB(255, 82, 255, 94)),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went Wrong. Please Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<List<BloodModel>> allBloodDetails(String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("Status", isEqualTo: "No")
        // .where("Email", isNotEqualTo: email)
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<List<BloodModel>> bloodDetailsCollege(
      String college, String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("College", isEqualTo: college)
        // .where("Email", isNotEqualTo: email)
        .where("Status", isEqualTo: "No")
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<List<BloodModel>> bloodDetailsBloodGroup(
      String bloodGroup, String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("BloodRequired", isEqualTo: bloodGroup)
        // .where("Email", isNotEqualTo: email)
        .where("Status", isEqualTo: "No")
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<List<BloodModel>> bloodDetailsPincode(
      String pincode, String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("PinCode", isEqualTo: pincode)
        // .where("Email", isNotEqualTo: email)
        .where("Status", isEqualTo: "No")
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<List<BloodModel>> bloodDetailsUserActive(String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("Email", isEqualTo: email)
        .where("Status", isEqualTo: "No")
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<List<BloodModel>> bloodDetailsUserCompleted(String email) async {
    final snapshot = await _db
        .collection("Blood_requests")
        .where("Email", isEqualTo: email)
        .where("Status", isEqualTo: "Yes")
        .orderBy('DateTime', descending: true)
        .get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }

  Future<void> updateBloodRecord(BloodModel reqBlood) async {
    await _db.collection("Blood_requests").doc(reqBlood.id).set({
      "NamePatient": reqBlood.fullName,
      "BloodRequired": reqBlood.reqBlood,
      "NOofUnit": reqBlood.noUnit,
      "PMobNum": reqBlood.phoneNo,
      "PinCode": reqBlood.pinCode,
      "College": reqBlood.college,
      "Status": reqBlood.status,
      "Email": reqBlood.email,
      "DateTime": reqBlood.dateTime,
      "Date": reqBlood.date,
      "Time": reqBlood.time,
      "FullName": reqBlood.fullName2,
      "BloodGroup": reqBlood.blood_group,
    });
  }
}
