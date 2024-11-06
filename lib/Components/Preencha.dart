import 'package:flutter/material.dart';

class Preencha {
  static dialogo(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Preencha todos os campos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static ONG_existente(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Esse email já está sendo utilizado por uma ONG'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static User_existente(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Esse email já está sendo utilizado por um usuário'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static senhaErrada(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('As senhas digitadas não são as mesmas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
