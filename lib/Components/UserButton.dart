import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.account_circle),
      color: AppColor.backgroundColor,
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'Usuario');
      },
    );
  }
}
