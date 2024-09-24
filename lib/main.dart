import 'package:flutter/material.dart';
import 'package:donapp/LoginMethods.dart';

void main() {
  runApp(const Donapp());
}

class Donapp extends StatefulWidget {
  const Donapp({super.key});

  @override
  State<Donapp> createState() => _DonappState();
}

class _DonappState extends State<Donapp> {
  int cont = 0;

  void incrementar() {
    setState(() {
      cont++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 26, 26, 26),
            appBar: AppBar(
              title: const Text('DonApp',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Katibeh')),
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
                    onPressed: () {},
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.white,
                  )
                ],
              ),
            )));
  }
}

_botao(cont, incrementar) {
  return Center(
      child: ElevatedButton(
          onPressed: () => {incrementar()}, child: Text(cont.toString())));
}

_body() {
  return Loginmethods();
}
