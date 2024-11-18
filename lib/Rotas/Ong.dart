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
  late int ongId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      ongId = args;
    } else {
      throw Exception('ID da ONG não foi fornecido ou é inválido.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra2(),
      body: _body(ongId),
      bottomNavigationBar: Bottombarra(),
    );
  }
}

_body(int id) {
  return Ongpage(
    ongId: id,
  );
}
