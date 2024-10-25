import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Components/BottomBarra.dart';
import 'package:donapp/Telas/PaginaUsuario.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  const Usuario({super.key});

  @override
  State<Usuario> createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
      bottomNavigationBar: Bottombarra(),
    );
  }

  _body() {
    return Paginausuario();
  }
}
