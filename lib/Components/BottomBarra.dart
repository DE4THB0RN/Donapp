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
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: AppColor.backgroundColor,
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'Home');
            },
            color: AppColor.backgroundColor,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: AppColor.backgroundColor,
          )
        ],
      ),
    );
  }
}