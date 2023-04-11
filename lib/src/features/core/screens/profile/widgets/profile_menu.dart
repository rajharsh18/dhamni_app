import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.tileColor,
    this.endCircleColor,
    this.endIconColor,
    this.iconCircleColor,
    this.iconIconColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? tileColor;
  final Color? endCircleColor;
  final Color? endIconColor;
  final Color? iconCircleColor;
  final Color? iconIconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconCircleColor?.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: iconIconColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: endCircleColor?.withOpacity(0.1),
              ),
              child: Icon(
                LineAwesomeIcons.angle_right,
                color: endIconColor,
                size: 18.0,
              ),
            )
          : null,
    );
  }
}
