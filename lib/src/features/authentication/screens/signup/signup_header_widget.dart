import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignupHeaderWidget extends StatelessWidget {
  const SignupHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(tWelcomeScreenImage),
          height: size.height * 0.2,
        ),
        Text(
          tSignUpTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(tSignUpSubTitle, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
