import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_follow.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/NGOCard.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Seguindopage extends StatefulWidget {
  const Seguindopage({super.key});

  @override
  State<Seguindopage> createState() => _SeguindopageState();
}

class _SeguindopageState extends State<Seguindopage> {
  late SharedPreferences prefs;
  bool isOng = false;
  List<Ongclass> ONGS = [];
  List<NGOCard> CardsOng = [];

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    bool? isOnger = prefs.getBool('is_ONG');
    if (isOnger != null) {
      setState(() {
        isOng = isOnger;
      });
    }
    initializeOngs();
  }

  void initializeOngs() async {
    String? emailUserTmp = prefs.getString('email');
    emailUserTmp = cipher.xorDecode(emailUserTmp!);
    List<Map<String, dynamic>> userTmp =
        await SQLUser.pegaUmUsuarioEmail2(emailUserTmp);
    int idUserTmp = userTmp.first['id'];
    List<Map<String, dynamic>> userFollow =
        await SQLFollow.pegafollowsUser(idUserTmp);
    if (userFollow.isNotEmpty) {
      for (dynamic i in userFollow) {
        List<Map<String, dynamic>> ong = await SQLONG.pegaUmaONG(i['id_ong']);
        ONGS.add(Ongclass(
            ong.first['nome'],
            ong.first['desc'],
            ong.first['foto_banner'],
            ong.first['foto_perfil'],
            ong.first['id']));
      }
      setState(() {
        updateCards();
      });
    }
  }

  void updateCards() {
    CardsOng.clear();
    for (Ongclass i in ONGS) {
      CardsOng.add(NGOCard(
          title: i.nome, description: i.desc, image: i.perfil, id: i.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isOng) ...[
              Padding(
                padding: Padinho.grande,
                child: Text(
                  "Faça login como doador para poder seguir outras ONGS",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ] else ...[
              if (ONGS.isEmpty) ...[
                Padding(
                  padding: Padinho.grande,
                  child: Text(
                    "Você ainda não segue nenhuma ONG",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ] else ...[
                Padding(
                  padding: Padinho.pequeno,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          for (int i = 0; i < ONGS.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: CardsOng[i],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }
}
