import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.name,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged, // Use the field
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}