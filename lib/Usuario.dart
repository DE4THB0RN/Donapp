import 'package:donapp/PaginaUsuario.dart';
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
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(
        title: const Text('DonApp',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontFamily: 'Katibeh')),
        backgroundColor: Color.fromARGB(255, 2, 54, 97),
      ),
      body: _body(),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 2, 54, 97),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'Home');
              },
              color: Colors.white,
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  _body() {
    return Paginausuario();
  }
}
