import 'package:donapp/OngPage.dart';
import 'package:flutter/material.dart';

class ONG extends StatefulWidget {
  const ONG({super.key});

  @override
  State<ONG> createState() => _ONGState();
}

class _ONGState extends State<ONG> {
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
                Navigator.pushNamed(context, 'Home');
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
    return Ongpage();
  }
}
