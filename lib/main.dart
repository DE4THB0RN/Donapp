import 'package:donapp/Cadastro.dart';
import 'package:donapp/EscolhaScreen.dart';
import 'package:donapp/HomeCall.dart';
import 'package:donapp/Login.dart';
import 'package:donapp/Ong.dart';
import 'package:donapp/Usuario.dart';
import 'package:flutter/material.dart';

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
        'Login': (context) => LoginScreen(),
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
