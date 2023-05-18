import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_user/authentication/controllers/login_controller.dart';
import 'package:rental_user/authentication/custom_config/background.dart';

class RegisterPage extends StatefulWidget {
  final LoginController controller;
  const RegisterPage({super.key, required this.controller});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  // SignUpController signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "REGISTER",
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
                key: widget.controller.signUpFormsKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(
                            Icons.people,
                            color: Color(0xFF2661FA),
                          ),
                        ),
                        onChanged: widget.controller.setName,
                        validator: widget.controller.validateName,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xFF2661FA),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                          // Limit the length to 10 digits
                        ],
                        onChanged: widget.controller.setPhone,
                        validator: widget.controller.validatePhoneNo,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });

                          await widget.controller.submitRegister(context);

                          setState(() {
                            _isLoading = false;
                          });
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
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'SIGN UP',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    "Already have an Account? Sign in",
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
      ),
    );
  }
}
