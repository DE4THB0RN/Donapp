import 'package:donapp/Components/AppBarra2.dart';
import 'package:donapp/Components/BottomBarra.dart';
import 'package:donapp/Telas/PostsSeguindoPage.dart';
import 'package:donapp/Theme/Color.dart';

import 'package:flutter/material.dart';

class Postseguindo extends StatefulWidget {
  const Postseguindo({super.key});

  @override
  State<Postseguindo> createState() => _PostseguindoState();
}

class _PostseguindoState extends State<Postseguindo> {
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
    return const postsSeguindo();
  }
}
