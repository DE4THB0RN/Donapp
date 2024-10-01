import 'package:donapp/CadastroScreen.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(
        title: const Text('DonApp',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontFamily: 'Katibeh')),
        backgroundColor: Color.fromARGB(255, 2, 54, 97),
      ),
      body: _body(),
    );
  }

  _body() {
    return CadastroScreen();
  }
}
