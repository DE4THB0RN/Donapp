import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class Bottombarra extends StatefulWidget {
  const Bottombarra({super.key});

  @override
  State<Bottombarra> createState() => _BottombarraState();
}

class _BottombarraState extends State<Bottombarra> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'Postseguindo');
            },
            color: AppColor.backgroundColor,
          ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'Home');
            },
            color: AppColor.backgroundColor,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'SeguindoPage');
            },
            color: AppColor.backgroundColor,
          )
        ],
      ),
    );
  }
}
