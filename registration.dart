import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivatech/component/text_button.dart';
import 'package:vivatech/component/text_form_field.dart';
import 'package:vivatech/controller/signup_controller.dart';
import 'package:vivatech/screens/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool _passwordShowHide = true;
  bool _confirmPasswordShowHide = true;

  void _passwordShowHideToggle() {
    setState(() {
      _passwordShowHide = !_passwordShowHide;
    });
  }

  void _confirmPasswordShowHideToggle() {
    setState(() {
      _confirmPasswordShowHide = !_confirmPasswordShowHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    matchPassword(String confirmPassword) {
      if (password.text == confirmPassword) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: const Color(0xff4e54c8),
      ),
      backgroundColor: const Color(0xff8a8ff7),
      resizeToAvoidBottomInset: false,
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
                  hintText: "Email",
                  requiredField: true,
                  validator: (email) {
                    if (isEmailValid(email)) {
                      return null;
                    } else {
                      return 'Enter a valid email address';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: password,
                  title: "Password",
                  hintText: "Password",
                  requiredField: true,
                  obscureText: _passwordShowHide,
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
                  height: 15,
                ),
                CustomTextFormField(
                  controller: confirmPassword,
                  title: "Confirm Password",
                  hintText: "Confirm Password",
                  requiredField: true,
                  obscureText: _confirmPasswordShowHide,
                  suffix: GestureDetector(
                      child: Icon(
                        _confirmPasswordShowHide
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white60,
                      ),
                      onTap: () => _confirmPasswordShowHideToggle()),
                  validator: (password) {
                    if (matchPassword(password)) {
                      if (isPasswordValid(password)) {
                        return null;
                      } else {
                        return 'Password min 6 length';
                      }
                    } else {
                      return 'Password not match';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    buttonName: "Registration",
                    buttonTextColor: Colors.white,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 2,
                      backgroundColor: const Color(0xff4e54c8),
                    ),
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        log(formGlobalKey.currentState!.toString());
                        SignupController.instance.registerUser(
                            email.text.trim(), password.text.trim());
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    CustomButton(
                      buttonName: "Sign in",
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xff4e54c8),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
