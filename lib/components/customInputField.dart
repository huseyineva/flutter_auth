import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final Color colorInput;
  final Color iconColor;
  final Color colorInputText;
  final String hintText;
  final IconData prefixIcon;
  final String validationMessage;

  CustomInputField({
    required this.controller,
    required this.colorInput,
    required this.iconColor,
    required this.colorInputText,
    required this.hintText,
    required this.prefixIcon,
    required this.validationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      margin: const EdgeInsets.symmetric(horizontal: 50.0),
      decoration: BoxDecoration(
        color: colorInput,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: colorInputText),
        ),
        style: TextStyle(color: colorInputText),
      ),
    );
  }
}
