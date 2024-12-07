import 'package:donapp/Components/AppBarra2.dart';
import 'package:donapp/Components/BottomBarra.dart';
import 'package:donapp/Theme/Color.dart';

import '../Telas/SeguindoPage.dart';
import 'package:flutter/material.dart';

class Seguindo extends StatefulWidget {
  const Seguindo({super.key});

  @override
  State<Seguindo> createState() => _SeguindoState();
}

class _SeguindoState extends State<Seguindo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const AppBarra2(),
      body: _body(),
      bottomNavigationBar: const Bottombarra(),
    );
  }

  _body() {
    return const Seguindopage();
  }
}
