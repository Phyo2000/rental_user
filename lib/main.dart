import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/controllers/login_controller.dart';
import 'package:rental_user/authentication/views/login_screen.dart';
import 'package:rental_user/authentication/views/otp_screen.dart';
import 'package:rental_user/authentication/views/register_screen.dart';
import 'package:rental_user/cart/views/cart_page.dart';
import 'package:rental_user/items/views/items_page.dart';
import 'package:rental_user/splash_screen.dart';
import 'package:rental_user/user/model/user_model.dart';

import 'home/views/home_page.dart';

void main() {
  runApp(RentalApp());
}

class RentalApp extends StatelessWidget {
  RentalApp({super.key});

  LoginController loginController = LoginController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelUser>(
          create: (_) => ModelUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rental App',
        theme: ThemeData(
          primaryColor: const Color(0xFF2661FA),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => LoginPage(
                loginController: loginController,
              ),
          '/register': (context) => RegisterPage(
                controller: loginController,
              ),
          '/home': (context) => const HomePage(),
          '/otp': (context) => OtpPage(
                loginController: loginController,
              ),
          '/cart': (context) => const CartPage(),
          '/item': (context) => ItemPage(),
        },
      ),
    );
  }
}
