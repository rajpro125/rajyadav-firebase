import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivatech/component/text_button.dart';
import 'package:vivatech/component/text_form_field.dart';
import 'package:vivatech/controller/signup_controller.dart';
import 'package:vivatech/screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool _passwordShowHide = true;

  void _passwordShowHideToggle() {
    setState(() {
      _passwordShowHide = !_passwordShowHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: const Color(0xff4e54c8),
        ),
        backgroundColor: const Color(0xff8a8ff7),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: email,
                      title: "Email",
                      requiredField: true,
                      hintText: "Email",
                      validator: (email) {
                        if (isEmailValid(email)) {
                          return null;
                        } else {
                          return 'Enter a valid email address';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      controller: password,
                      title: "Password",
                      requiredField: true,
                      obscureText: _passwordShowHide,
                      hintText: "Password",
                      suffix: GestureDetector(
                          child: Icon(
                            _passwordShowHide
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white60,
                          ),
                          onTap: () => _passwordShowHideToggle()),
                      validator: (password) {
                        if (isPasswordValid(password)) {
                          return null;
                        } else {
                          return 'Password min 6 length';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        buttonName: "Login",
                        buttonTextColor: Colors.white,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          elevation: 2,
                          backgroundColor: const Color(0xff4e54c8),
                        ),
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();

                            SignupController.instance.loginUser(
                                email.text.trim(), password.text.trim());
                            // use the email provided here
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account yet?",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        CustomButton(
                          buttonName: "Register",
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff4e54c8),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
