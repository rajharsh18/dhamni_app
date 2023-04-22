import 'package:cloud_firestore/cloud_firestore.dart';

class BloodModel {
  final String? id;
  final String fullName;
  final String reqBlood;
  final String noUnit;
  final String phoneNo;
  final String pinCode;
  final String college;
  final String status;
  final String email;
  final Timestamp dateTime;
  final String date;
  final String time;
  final String fullName2;

  const BloodModel({
    this.id,
    required this.fullName,
    required this.reqBlood,
    required this.noUnit,
    required this.phoneNo,
    required this.pinCode,
    required this.college,
    required this.status,
    required this.email,
    required this.dateTime,
    required this.date,
    required this.time,
    required this.fullName2,
  });

  toJson() {
    return {
      "NamePatient": fullName,
      "BloodRequired": reqBlood,
      "NOofUnit": noUnit,
      "PMobNum": phoneNo,
      "PinCode": pinCode,
      "College": college,
      "Status": status,
      "Email": email,
      "DateTime": dateTime,
      "Date": date,
      "Time": time,
      "FullName": fullName2,
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
      college: data["College"],
      status: data["Status"],
      email: data["Email"],
      dateTime: data["DateTime"],
      date: data["Date"],
      time: data["Time"],
      fullName2: data["FullName"],
    );
  }
}
