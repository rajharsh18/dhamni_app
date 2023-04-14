// import 'package:dhamni/src/constants/sizes.dart';
// import 'package:dhamni/src/constants/text_strings.dart';
// import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ForgetPasswordPhoneForm extends StatelessWidget {
//   const ForgetPasswordPhoneForm({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.person_outline_outlined),
//                   labelText: tPhoneNo,
//                   hintText: tPhoneNo,
//                   border: OutlineInputBorder()),
//             ),
//             SizedBox(
//               height: tFormHeight - 20,
//             ),
//             SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     onPressed: () {
//                       Get.to(() => const OTPScreen(
//                             user: null,
//                           ));
//                     },
//                     child: Text(tNext.toUpperCase())))
//           ],
//         ),
//       ),
//     );
//   }
// }
