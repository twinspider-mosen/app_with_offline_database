import 'package:app_with_local_database/constants/constant.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  const PasswordField(
      {super.key,
      required this.label,
      required this.controller,
      required this.obscure});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscure,
        decoration: InputDecoration(
            fillColor: lightBg,
            filled: true,
            prefixIcon: Icon(Icons.key),
            hintText: widget.label,
            suffixIcon: Icon(Icons.visibility_off),
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
