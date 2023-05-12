import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: const [
          Icon(
            Icons.person,
            size: 30,
            color: mainColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
