import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Function(DateTime) onDateSelected;

  CustomDateInputField({
    required this.labelText,
    required this.hintText,
    required this.onDateSelected,
  });

  @override
  _CustomDateInputFieldState createState() => _CustomDateInputFieldState();
}

class _CustomDateInputFieldState extends State<CustomDateInputField> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
