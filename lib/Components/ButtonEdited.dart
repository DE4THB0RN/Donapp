import 'package:flutter/material.dart';

Widget ButtonEdited({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple[100], // Cor do botão
      foregroundColor: Colors.black, // Cor do texto e ícone
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Bordas arredondadas
      ),
    ),
  );
}