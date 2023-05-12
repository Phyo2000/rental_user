import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/profile/widgets/profile_appbar.dart';
import 'package:rental_user/profile/widgets/profile_menu.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ProfileAppBar(),
        Container(
          height: 680,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: Color(0xFFEDECF2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://t3.ftcdn.net/jpg/04/98/91/96/240_F_498919631_Me4XD0pVj0tX109wnyH7FIo6FHTb5J0E.jpg"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Rachel Andrews",
                style: TextStyle(
                  fontSize: 25,
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "09768192083",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 47,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Your Favourite",
                icon: Icons.favorite,
                textColor: mainColor,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Your Cart",
                icon: Icons.shopping_cart,
                textColor: mainColor,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Your Rent",
                icon: Icons.list,
                textColor: mainColor,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Logout",
                icon: Icons.logout,
                textColor: Colors.redAccent,
                endIcon: false,
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
