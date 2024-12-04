import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomInputFieldMoney extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<double> onChanged;
  final TextEditingController? controller;

  const CustomInputFieldMoney({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.controller,
    super.key,
  });

  @override
  State<CustomInputFieldMoney> createState() => _CustomInputFieldMoneyState();
}

class _CustomInputFieldMoneyState extends State<CustomInputFieldMoney> {
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
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          inputFormatters: [
            _CentavosInputFormatter(), // Novo formatter para começar com centavos
          ],
          onChanged: (value) {
            // Remove símbolos e converte para double
            final numericValue =
                double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ??
                    0.0;
            widget.onChanged(numericValue);
          },
        ),
      ],
    );
  }
}

class _CentavosInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove caracteres não numéricos
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return TextEditingValue(
        text: 'R\$0,00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    // Converte para centavos
    final double value = double.parse(digitsOnly) / 100;

    // Formata como moeda
    final newText = _currencyFormat.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
