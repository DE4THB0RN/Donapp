import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      color: AppColor.backgroundColor,
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'Usuario');
      },
    );
  }
}
