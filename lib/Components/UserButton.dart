import 'package:donapp/Components/Helper.dart';
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

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () async {
        bool? isONG = prefs.getBool('is_ONG');
        if (isONG!) {
          Navigator.pushReplacementNamed(
            context,
            'ONG',
            arguments: await _pegaId(),
          );
        } else {
          Navigator.pushReplacementNamed(context, 'Usuario');
        }
      },
    );
  }

  Future<int> _pegaId() async {
    final prefs = await SharedPreferences.getInstance();
    String? emailtoken = prefs.getString('email');
    String email = cipher.xorDecode(emailtoken!);

    int id = await SQLONG.pegaIdOng(email);
    print(id);
    return id;
  }
}
