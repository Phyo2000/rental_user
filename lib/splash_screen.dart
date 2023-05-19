import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/user/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  Future<void> checkCredentials() async {
    await Future.delayed(const Duration(
        milliseconds: 500)); // Delay to allow widget tree to build

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? credentials = prefs.getStringList('credentials');

    if (credentials != null && credentials.isNotEmpty) {
      // if credentials exist, navigate to home screen

      ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
      modelUser.setUser(
          id: credentials[0],
          name: credentials[1],
          username: credentials[2],
          phone: credentials[3],
          token: credentials[4]);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // No credentials, navigate to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    ;
  }
}
