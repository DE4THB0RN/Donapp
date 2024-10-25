import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Escolha.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class Escolhascreen extends StatefulWidget {
  const Escolhascreen({super.key});

  @override
  State<Escolhascreen> createState() => _EscolhascreenState();
}

class _EscolhascreenState extends State<Escolhascreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return Escolha();
  }
}
