import 'package:app_with_local_database/constants/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          child: Center(
              child: Text(
            '$title',
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
          width: double.infinity,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
