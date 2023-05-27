import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonName;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
   final Color? buttonTextColor;
  const CustomButton({super.key, this.buttonName, this.onPressed, this.style, this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: onPressed,
      child: Text(
        buttonName!,
        style: TextStyle(
          fontSize: 18,
          letterSpacing: 1,
          color: buttonTextColor
        ),
      ),
    );
  }
}
