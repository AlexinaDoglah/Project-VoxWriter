import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.TextEditingController,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(40),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),

          borderRadius: BorderRadius.circular(40),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black12),
      ),
      controller: TextEditingController,
      obscureText: obscureText,
    );
  }
}