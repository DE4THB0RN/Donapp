import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputFieldMoney extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged onChanged;
  final TextEditingController? controller;

  const CustomInputFieldMoney({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.controller,
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
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          obscureText: false,
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
