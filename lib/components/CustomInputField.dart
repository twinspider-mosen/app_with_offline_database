import 'package:app_with_local_database/constants/constant.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  const CustomInputField(
      {super.key, required this.label, required this.controller, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: lightBg,
            filled: true,
            hintText: label,
            prefixIcon: icon != null ? Icon(icon) : null,
            hintStyle: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 18),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
