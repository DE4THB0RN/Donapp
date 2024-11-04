import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Telas/Cadastro2ong.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class ONG_Cadastro2 extends StatefulWidget {
  const ONG_Cadastro2({super.key});

  @override
  State<ONG_Cadastro2> createState() => _ONG_Cadastro2State();
}

class _ONG_Cadastro2State extends State<ONG_Cadastro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return Cadastro2Ong();
  }
}
