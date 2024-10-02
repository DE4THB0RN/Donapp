import 'Home.dart';
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
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        title: const Text('DonApp',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontFamily: 'Katibeh')),
        backgroundColor: Color.fromARGB(255, 2, 54, 97),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'Usuario');
            },
          ),
        ],
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
      ),
    );
  }

  _body() {
    return Home();
  }
}
