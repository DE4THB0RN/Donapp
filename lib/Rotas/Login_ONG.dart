import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Telas/LoginPage_ONG.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class LoginONG extends StatefulWidget {
  const LoginONG({super.key});

  @override
  State<LoginONG> createState() => _LoginONGState();
}

class _LoginONGState extends State<LoginONG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return Loginpage_ONGState();
  }
}
