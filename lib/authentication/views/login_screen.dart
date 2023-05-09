import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_user/authentication/controllers/login_controller.dart';
import 'package:rental_user/authentication/custom_config/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = LoginController();

  //final model = LoginModel();

  // bool obsecurePwd = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Form(
              key: loginController.loginFormKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xFF2661FA),
                          )),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        // Limit the length to 10 digits
                      ],
                      onChanged: loginController.setPhone,
                      validator: loginController.validatePhoneNo,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   margin: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       labelText: 'Password',
                  //       prefixIcon: const Icon(Icons.lock_outline),
                  //       prefixIconColor: const Color(0xFF2661FA),
                  //       suffixIcon: IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             obsecurePwd = !obsecurePwd;
                  //           });
                  //         },
                  //         icon: obsecurePwd
                  //             ? const Icon(
                  //                 Icons.visibility_off_outlined,
                  //                 color: Colors.black38,
                  //               )
                  //             : const Icon(
                  //                 Icons.visibility_outlined,
                  //                 color: Color(0xFF2661FA),
                  //               ),
                  //       ),
                  //     ),
                  //     obscureText: obsecurePwd,
                  //     inputFormatters: [
                  //       FilteringTextInputFormatter.deny(
                  //           RegExp('[ ]')), // Disallow spaces
                  //       LengthLimitingTextInputFormatter(
                  //           50), // Limit the length to 50 characters
                  //       //PasswordValidator(),
                  //     ],
                  //     validator: model.validatePassword,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2661FA),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  loginController.submit(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41),
                    ]),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    'LOG IN',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Don't have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
