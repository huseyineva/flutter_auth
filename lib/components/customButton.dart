import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  CustomButton({required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Color colorPurple = const Color(0xFF5C27FE);

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 200,
          height: 55,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorPurple,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
