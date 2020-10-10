import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.color,
      this.onPressed,
      this.buttonText,
      this.borderRadius = 4.0,
      this.buttonHeight = 44.0});

  final Color color;
  final VoidCallback onPressed;
  final String buttonText;
  final double buttonHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      child: RaisedButton(
        elevation: 4.4,
        child: Text(buttonText),
        color: color,
        disabledColor: color,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
