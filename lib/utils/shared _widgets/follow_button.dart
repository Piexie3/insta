import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? pressed;
  final Color backgroundColor;
  final Color boderColor;
  final String text;
  final Color textColor;
  const FollowButton({
    super.key,
    this.pressed,
    required this.backgroundColor,
    required this.boderColor,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 28),
      child: TextButton(
        onPressed: pressed,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: boderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          height: 27,
          width: 270,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
