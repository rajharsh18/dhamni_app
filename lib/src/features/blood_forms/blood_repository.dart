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
          () => Get.snackbar("Success", "Your Request has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went Wrong. Please Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<List<BloodModel>> allBloodDetails() async {
    final snapshot = await _db.collection("Blood_requests").get();
    final bloodData =
        snapshot.docs.map((e) => BloodModel.fromSnapshot(e)).toList();
    return bloodData;
  }
}
