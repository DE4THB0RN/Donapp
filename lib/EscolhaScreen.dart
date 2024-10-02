import 'package:donapp/Escolha.dart';
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
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        title: const Text('DonApp',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontFamily: 'Katibeh')),
        backgroundColor: Color.fromARGB(255, 2, 54, 97),
      ),
      body: _body(),
    );
  }

  _body() {
    return Escolha();
  }
}
