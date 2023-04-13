import 'package:dhamni/src/features/blood_forms/blood_data.dart';
import 'package:dhamni/src/features/blood_forms/blood_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodController extends GetxController {
  static BloodController get instance => Get.find();

  final fullName = TextEditingController();
  final noUnit = TextEditingController();
  final phoneNo = TextEditingController();
  final pinCode = TextEditingController();

  final _bloodRepo = Get.put(BloodRepository());

  Future<void> addRequest(BloodModel reqblood) async {
    await _bloodRepo.addRequest(reqblood);
  }

  Future<List<BloodModel>> getAllRequest() async {
    return await _bloodRepo.allBloodDetails();
  }

  Future<List<BloodModel>> getPincodeRequest(String pincode) async {
    return await _bloodRepo.bloodDetailsPincode(pincode);
  }

  Future<List<BloodModel>> getCollegeRequest(String college) async {
    return await _bloodRepo.bloodDetailsCollege(college);
  }

  Future<List<BloodModel>> getUserRequestActive(String email) async {
    return await _bloodRepo.bloodDetailsUserActive(email);
  }

  Future<List<BloodModel>> getUserRequestCompleted(String email) async {
    return await _bloodRepo.bloodDetailsUserCompleted(email);
  }

  UpdateBloodRecord(BloodModel reqBlood) async {
    await _bloodRepo.updateBloodRecord(reqBlood);
  }
}
