import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_donate.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/BD/sql_post.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';

class Escolha extends StatefulWidget {
  const Escolha({super.key});

  @override
  State<Escolha> createState() => _EscolhaState();
}

class _EscolhaState extends State<Escolha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              "assets/funciona.jpg",
              fit: BoxFit.cover, // Ajusta a imagem ao tamanho da tela
            ),
          ),
          // Conteúdo sobreposto
          Padding(
            padding: Padinho.grande,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _botao(context, 'Quero doar', 'Cadastro_User'),
                SizedBox(height: 20), // Espaço entre os botões
                _botao(context, 'Sou uma ONG', 'Cadastro_ONG'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //dores();
  }

  void dores() async {
    await SQLLocal.dropDataBaseLocal();
    await SQLONG.dropDataBaseONG();
    await SQLUser.dropDataBaseUser();
    await SQLDonate.dropDataBaseDonate();
    await SqlPost.dropDataBasePost();
  }
}

Widget _botao(BuildContext context, String text, String destino) {
  return SizedBox(
    width: double.infinity, // Largura ocupando toda a tela
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: AppColor.appBarColor.withOpacity(0.8), // Transparência
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
        ),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, destino.toString());
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'Katibeh',
        ),
      ),
    ),
  );
}
