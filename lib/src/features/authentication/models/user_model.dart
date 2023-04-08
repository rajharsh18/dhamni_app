import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String collegeName;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.fullName,
    required this.collegeName,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "CollegeName": collegeName,
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
    );
  }
}
