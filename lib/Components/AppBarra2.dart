import 'package:donapp/Components/UserButton.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class AppBarra2 extends StatelessWidget implements PreferredSizeWidget {
  const AppBarra2({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('DonApp',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontFamily: 'Katibeh')),
      backgroundColor: AppColor.appBarColor,
      actions: [
        ProfileIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
