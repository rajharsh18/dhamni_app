import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String collegeName;
  final String pinCode;
  final String dateTime;
  final String date;
  final String time;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.fullName,
    required this.collegeName,
    required this.pinCode,
    required this.dateTime,
    required this.date,
    required this.time,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "CollegeName": collegeName,
      "PinCode": pinCode,
      "DateTime": dateTime,
      "Date": date,
      "Time": time,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      password: data["Password"],
      phoneNo: data["Phone"],
      fullName: data["FullName"],
      collegeName: data["CollegeName"],
      pinCode: data["PinCode"],
      dateTime: data["DateTime"],
      date: data["Date"],
      time: data["Time"],
    );
  }
}
