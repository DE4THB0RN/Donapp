import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Telas/CadastroOng.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class ONG_Cadastro extends StatefulWidget {
  const ONG_Cadastro({super.key});

  @override
  State<ONG_Cadastro> createState() => _ONG_CadastroState();
}

class _ONG_CadastroState extends State<ONG_Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return CadastroOng();
  }
}
