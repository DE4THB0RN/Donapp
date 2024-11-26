import 'package:flutter/material.dart';
import 'package:donapp/Theme/Color.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.appBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey, // Cor de fundo para o botão "Não"
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () {
                    onCancel();
                    Navigator.pop(context); // Fecha o pop-up
                  },
                  child: const Text(
                    'Não',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red, // Cor de fundo para o botão "Sim"
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.pop(context); // Fecha o pop-up
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}