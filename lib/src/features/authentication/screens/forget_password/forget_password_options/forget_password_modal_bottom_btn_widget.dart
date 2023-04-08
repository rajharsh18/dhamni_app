import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:dhamni/src/features/authentication/screens/forget_password/forget_password_phone/forget_password_phone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShoeModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            tForgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            tForgetPasswordSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: tFormHeight,
          ),
          ForgetPasswordBtnWidget(
            btnIcon: Icons.mail_outline_rounded,
            title: tEmail,
            subTitle: tResetViaEMail,
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ForgetPasswordMailScreen());
            },
          ),
          SizedBox(
            height: tFormHeight - 20.0,
          ),
          // ForgetPasswordBtnWidget(
          //   btnIcon: Icons.mobile_friendly_rounded,
          //   title: tPhoneNo,
          //   subTitle: tResetViaPhone,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Get.to(() => ForgetPasswordPhoneScreen());
          //   },
          // ),
        ]),
      ),
    );
  }
}
