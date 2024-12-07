import 'package:donapp/Components/AppBarra.dart';
import 'package:donapp/Telas/LoginPage.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const AppBarra(),
      body: _body(),
    );
  }

  _body() {
    return const LoginpageState();
  }
}
