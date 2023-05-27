import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool requiredField;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final Widget? suffix;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    this.title,
    this.hintText,
    this.requiredField = false,
    this.controller,
    this.validator,
    this.suffix,
    this.obscureText = false,
  });

  static OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: Colors.white),
    borderRadius: BorderRadius.circular(15.0),
  );

  // static InputBorder? border1 = InputBorder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Visibility(
                visible: requiredField,
                child: const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            isDense: true,
            hintText: hintText ?? "",
            hintStyle: const TextStyle(color: Colors.white60),
            suffix: suffix,
          ),
          maxLines: 1,
          validator: validator,
        )
      ],
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}

mixin InputValidationMixin {}

bool isPasswordValid(String password) => password.length >= 6;

bool isEmailValid(String email) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
