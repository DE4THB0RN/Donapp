import 'package:donapp/OngPage.dart';
import 'package:flutter/material.dart';
import 'package:donapp/LoginMethods.dart';

void main() {
  runApp(Donapp());
}

class Donapp extends StatefulWidget {
  Donapp({super.key});

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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('DonApp', style: TextStyle(color: Colors.white)),
                  Icon(Icons.home)
                ],
              ),
              backgroundColor: Color.fromARGB(255, 2, 54, 97),
            ),
            body: _body(),
            bottomNavigationBar: BottomAppBar(
              color: Color.fromARGB(255, 2, 54, 97),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.notifications,
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
  return Ongpage();
}
