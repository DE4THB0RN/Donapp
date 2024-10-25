import 'package:donapp/Telas/CadastroScreen.dart';
import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Theme/Color.dart';
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
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return CadastroScreen();
  }
}
