import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_follow.dart';
import 'package:donapp/BD/sql_post.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Components/PostCard.dart';
import 'package:donapp/Components/PostClass.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class postsSeguindo extends StatefulWidget {
  const postsSeguindo({super.key});

  @override
  State<postsSeguindo> createState() => _postsSeguindoState();
}

class _postsSeguindoState extends State<postsSeguindo> {
  late SharedPreferences prefs;
  bool isOng = false;
  List<Ongclass> ONGS = [];
  List<int> postsPerOng = [];
  List<Postclass> postagens = [];
  List<Postcard> postCards = [];
  int ongCount = 0;

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
    if (!isOng) {
      initializePosts();
    }
  }

  void initializePosts() async {
    String? emailUserTmp = prefs.getString('email');
    emailUserTmp = cipher.xorDecode(emailUserTmp!);
    List<Map<String, dynamic>> userTmp =
        await SQLUser.pegaUmUsuarioEmail2(emailUserTmp);
    int idUserTmp = userTmp.first['id'];
    List<Map<String, dynamic>> userFollow =
        await SQLFollow.pegafollowsUser(idUserTmp);
    ongCount = 0;
    if (userFollow.isNotEmpty) {
      for (dynamic i in userFollow) {
        ongCount++;
        List<Map<String, dynamic>> ong = await SQLONG.pegaUmaONG(i['id_ong']);
        ONGS.add(Ongclass(
            ong.first['nome'],
            ong.first['desc'],
            ong.first['foto_banner'],
            ong.first['foto_perfil'],
            ong.first['id']));
        List<Map<String, dynamic>> posts =
            await SqlPost.pegaPostsOng(i['id_ong']);
        int postCount = 0;
        for (dynamic j in posts) {
          postagens.add(
              Postclass(j['titulo'], j['descricao'], j['imagem'], j['id']));
          postCount++;
        }
        postsPerOng.add(postCount);
      }
      setState(() {
        updateCards();
      });
    }
  }

  void updateCards() {
    postCards.clear();
    for (Postclass i in postagens) {
      postCards.add(Postcard(
          image: i.imagem, title: i.titulo, description: i.coment, id: i.id));
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
                  "Faça login como doador para poder seguir outras ONGS e ver suas postagens",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ] else ...[
              if (postagens.isEmpty) ...[
                Padding(
                  padding: Padinho.grande,
                  child: Text(
                    "Você ainda não segue nenhuma ONG ou as ONGS que você segue não fizeram postagens",
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
                          for (int i = 0; i < postagens.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: postCards[i],
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
