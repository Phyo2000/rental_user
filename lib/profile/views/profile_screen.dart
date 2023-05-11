import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/profile/widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                      "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?w=1380&t=st=1683777636~exp=1683778236~hmac=a9a691f62697f1cf33cd5abd25ddc13171df61e8e7b70f8a8a2d8cc3de987097"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Rachel Andrews",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "09768192083",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
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
                icon: Icons.settings,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Your Cart",
                icon: Icons.settings,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "Your Rent",
                icon: Icons.settings,
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
      ),
    );
  }
}
