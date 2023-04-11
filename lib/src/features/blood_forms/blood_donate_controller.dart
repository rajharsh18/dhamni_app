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
  final bloodRepo = Get.put(BloodRepository());

  Future<void> addRequest(BloodModel reqblood) async {
    await bloodRepo.addRequest(reqblood);
  }

  Future<List<BloodModel>> getAllRequest() async {
    return await _bloodRepo.allBloodDetails();
  }
}
