import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: mainColor.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: mainColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mainColor.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 18,
                color: mainColor,
              ),
            )
          : null,
    );
  }
}
