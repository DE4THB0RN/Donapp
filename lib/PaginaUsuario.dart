import 'package:flutter/material.dart';

class Paginausuario extends StatefulWidget {
  const Paginausuario({super.key});

  @override
  State<Paginausuario> createState() => _PaginausuarioState();
}

class _PaginausuarioState extends State<Paginausuario> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: CircleAvatar(
            radius: 56,
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset("assets/avatar.png"),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
