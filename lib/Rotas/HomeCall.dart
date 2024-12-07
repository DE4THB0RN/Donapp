import 'package:donapp/Components/AppBarra2.dart';
import 'package:donapp/Components/BottomBarra.dart';
import 'package:donapp/Theme/Color.dart';

import '../Telas/Home.dart';
import 'package:flutter/material.dart';

class Homecall extends StatefulWidget {
  const Homecall({super.key});

  @override
  State<Homecall> createState() => _HomecallState();
}

class _HomecallState extends State<Homecall> {
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
    return const Home();
  }
}
