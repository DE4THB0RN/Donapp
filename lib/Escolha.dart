import 'package:flutter/material.dart';

class Escolha extends StatefulWidget {
  const Escolha({super.key});

  @override
  State<Escolha> createState() => _EscolhaState();
}

class _EscolhaState extends State<Escolha> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 600,
            child: _botao(context, 'Quero doar', 'Cadastro'),
          ),
          Padding(padding: EdgeInsets.all(60)),
          SizedBox(
            width: 600,
            child: _botao(context, 'Sou uma ONG', 'Cadastro'),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

_botao(context, text, destino) {
  return ElevatedButton(
    style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Color.fromARGB(255, 2, 54, 97))),
    onPressed: () => {
      Navigator.pushReplacementNamed(context, destino.toString()),
    },
    child: Center(
      child: Text(
        '$text',
        style:
            TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Katibeh'),
      ),
    ),
  );
}
