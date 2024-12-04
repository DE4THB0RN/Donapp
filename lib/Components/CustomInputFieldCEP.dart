import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputFieldCEP extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController? controller;

  const CustomInputFieldCEP({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    this.controller,
    super.key,
  });

  @override
  State<CustomInputFieldCEP> createState() => _CustomInputFieldCEPState();
}

class _CustomInputFieldCEPState extends State<CustomInputFieldCEP> {
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
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          obscureText: false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }
}
