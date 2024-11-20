import 'package:flutter/material.dart';

class CustomInputFieldMoney extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomInputFieldMoney({
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    required this.controller,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
