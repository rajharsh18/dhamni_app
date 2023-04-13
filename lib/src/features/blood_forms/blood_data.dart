import 'package:cloud_firestore/cloud_firestore.dart';

class BloodModel {
  final String? id;
  final String fullName;
  final String reqBlood;
  final String noUnit;
  final String phoneNo;
  final String pinCode;
  final String College;
  final String Status;
  final String email;

  const BloodModel({
    this.id,
    required this.fullName,
    required this.reqBlood,
    required this.noUnit,
    required this.phoneNo,
    required this.pinCode,
    required this.College,
    required this.Status,
    required this.email,
  });

  toJson() {
    return {
      "NamePatient": fullName,
      "BloodRequired": reqBlood,
      "NOofUnit": noUnit,
      "PMobNum": phoneNo,
      "PinCode": pinCode,
      "College": College,
      "Status": Status,
      "Email": email,
    };
  }

  factory BloodModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return BloodModel(
      id: document.id,
      fullName: data["NamePatient"],
      reqBlood: data["BloodRequired"],
      noUnit: data["NOofUnit"],
      phoneNo: data["PMobNum"],
      pinCode: data["PinCode"],
      College: data["College"],
      Status: data["Status"],
      email: data["Email"],
    );
  }
}
