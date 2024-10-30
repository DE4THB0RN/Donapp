import 'package:donapp/Rotas/Cadastro.dart';

import 'package:donapp/Rotas/HomeCall.dart';
import 'package:donapp/Rotas/Ong.dart';
import 'package:donapp/Rotas/EscolhaScreen.dart';
import 'package:donapp/Rotas/Usuario.dart';
import 'package:flutter/material.dart';

import 'Rotas/Login.dart';

void main() {
  runApp(const Donapp());
}

class Donapp extends StatefulWidget {
  const Donapp({super.key});

  @override
  State<Donapp> createState() => _DonappState();
}

class _DonappState extends State<Donapp> {
  int cont = 0;

  void incrementar() {
    setState(() {
      cont++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: _body(),
      routes: {
        'Escolha': (context) => Escolhascreen(),
        'Cadastro': (context) => Cadastro(),
        'Usuario': (context) => Usuario(),
        'Home': (context) => Homecall(),
        'ONG': (context) => ONG(),
        'Login': (context) => Login(),
      },
    );
  }
}

_botao(cont, incrementar) {
  return Center(
      child: ElevatedButton(
          onPressed: () => {incrementar()}, child: Text(cont.toString())));
}

_body() {
  return Escolhascreen();
}
