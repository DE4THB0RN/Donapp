import 'package:donapp/Components/AppBarra2.dart';
import 'package:donapp/Components/BottomBarra.dart';
import 'package:donapp/Telas/OngPage.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class ONG extends StatefulWidget {
  const ONG({super.key});

  @override
  State<ONG> createState() => _ONGState();
}

class _ONGState extends State<ONG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra2(),
      body: _body(),
      bottomNavigationBar: Bottombarra()
    );
  }

  _body() {
    return Ongpage();
  }
}
