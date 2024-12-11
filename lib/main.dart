import 'package:donapp/Rotas/Cadastro.dart';

import 'package:donapp/Rotas/HomeCall.dart';
import 'package:donapp/Rotas/Login_ONG.dart';
import 'package:donapp/Rotas/ONG_Cadastro.dart';
import 'package:donapp/Rotas/ONG_Cadastro2.dart';
import 'package:donapp/Rotas/Ong.dart';
import 'package:donapp/Rotas/EscolhaScreen.dart';
import 'package:donapp/Rotas/PostSeguindo.dart';
import 'package:donapp/Rotas/Seguindo.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      home: _body(),
      routes: {
        'Escolha': (context) => const Escolhascreen(),
        'Cadastro_User': (context) => const Cadastro(),
        'Usuario': (context) => const Usuario(),
        'Home': (context) => const Homecall(),
        'ONG': (context) => const ONG(),
        'Login_User': (context) => const Login(),
        'Login_ONG': (context) => const LoginONG(),
        'Cadastro_ONG': (context) => const ONG_Cadastro(),
        'Cadastro_ONG2': (context) => const ONG_Cadastro2(),
        'SeguindoPage': (context) => const Seguindo(),
        'Postseguindo': (context) => const Postseguindo(),
      },
    );
  }
}

_body() {
  return const Escolhascreen();
}
