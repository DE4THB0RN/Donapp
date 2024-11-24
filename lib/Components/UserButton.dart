import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:donapp/BD/sql_ONG.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({super.key});

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  late SharedPreferences prefs;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      color: isLoading ? Colors.grey : AppColor.backgroundColor,
      onPressed: isLoading
          ? null
          : () {
              final isONG = prefs.getBool('is_ONG') ?? false;
              if (isONG) {
                Navigator.pushReplacementNamed(context, 'ONG');
              } else {
                Navigator.pushReplacementNamed(context, 'Usuario');
              }
            },
    );
  }


  int _pegaId() async {
    final prefs = await SharedPreferences.getInstance();
    String? emailcrip = prefs.getString('email');
    String email = cipher.xorDecode(emailcrip!);
    


    return id;
  }


}
