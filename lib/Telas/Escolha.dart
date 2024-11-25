import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/GenericImages.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';

class Escolha extends StatefulWidget {
  const Escolha({super.key});

  @override
  State<Escolha> createState() => _EscolhaState();
}

class _EscolhaState extends State<Escolha> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: _botao(context, 'Quero doar', 'Cadastro_User'),
          ),
          Padding(padding: EdgeInsets.all(60)),
          SizedBox(
            width: 600,
            child: _botao(context, 'Sou uma ONG', 'Cadastro_ONG'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //dores();
    //iniciarOngsMock();
  }

  void dores() async {
    await SQLLocal.dropDataBaseLocal();
    await SQLONG.dropDataBaseONG();
    await SQLUser.dropDataBaseUser();
  }

  void iniciarOngsMock() async {
    SQLONG.adicionarONG("", "ongsaude@gmail.com", "", "");
    SQLONG.atualizaONG(
        await SQLONG.pegaIdOng("ongsaude@gmail.com"),
        "ONG SAÚDE",
        "839289482789",
        "ongsaude@gmail.com",
        generateMd5("senha"),
        "descrição",
        await genericProfile(),
        await genericBanner());
    SQLONG.adicionarONG("", "ongcomida@gmail.com", "", "");
    SQLONG.atualizaONG(
        await SQLONG.pegaIdOng("ongcomida@gmail.com"),
        "ONG COMIDA",
        "6466456464556",
        "ongcomida@gmail.com",
        generateMd5("senha"),
        "descrição",
        await genericProfile(),
        await genericBanner());

    SQLONG.adicionarONG("", "ongrefugiados@gmail.com", "", "");
    SQLONG.atualizaONG(
        await SQLONG.pegaIdOng("ongrefugiados@gmail.com"),
        "ONG REFUGIADOS",
        "3534536643656",
        "ongrefugiados@gmail.com",
        generateMd5("senha"),
        "descrição",
        await genericProfile(),
        await genericBanner());
  }
}

_botao(context, text, destino) {
  return ElevatedButton(
    style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColor.appBarColor)),
    onPressed: () => {
      Navigator.pushReplacementNamed(context, destino.toString()),
    },
    child: Center(
      child: Text(
        '$text',
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontFamily: 'Katibeh'),
      ),
    ),
  );
}
