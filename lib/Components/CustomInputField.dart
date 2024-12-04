import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController? controller;

  const CustomInputField({
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    required this.onChanged,
    required this.onSubmitted,
    this.controller,
    super.key,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
