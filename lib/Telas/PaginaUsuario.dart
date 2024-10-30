import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paginausuario extends StatefulWidget {
  const Paginausuario({super.key});

  @override
  State<Paginausuario> createState() => _PaginausuarioState();
}

class _PaginausuarioState extends State<Paginausuario> {
  String nome = 'Usuário';
  String senha = '';
  String email = '';
  String nomeedit = '';
  String senhaedit = '';

  @override
  void initState() {
    super.initState();
    _setarDados();
  }

  void _setarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailtoken = prefs.getString('email');
    String? senhatoken = prefs.getString('senha');
    String? nometoken = prefs.getString('nome');
    Cipher cipher = Cipher();
    if (emailtoken != null && senhatoken != null && nometoken != null) {
      setState(() {
        nome = cipher.xorDecode(nometoken);
        senha = cipher.xorDecode(senhatoken);
        email = cipher.xorDecode(emailtoken);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: Padinho.medio,
                  child: Center(
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: ClipOval(
                          child: Image.asset("assets/avatar.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    nome,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontFamily: 'Katibeh',
                    ),
                  ),
                ),
                Padding(
                  padding: Padinho.medio,
                  child: Center(
                    child: Text(
                      '300 seguindo',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(40)),
                Padding(
                  padding: Padinho.medio,
                  child: Center(
                    child: Text(
                      'Histórico de doações',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Katibeh',
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _donation('ONG 1', '01/01/2021', 'R\$ 100,00'),
                        _donation('ONG 2', '02/01/2021', 'R\$ 200,00'),
                        _donation('ONG 3', '03/01/2021', 'R\$ 300,00'),
                        _donation('ONG 4', '04/01/2021', 'R\$ 400,00'),
                        _donation('ONG 5', '05/01/2021', 'R\$ 500,00'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.black, size: 28),
                onPressed: () {
                  _openEditUserPopup(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para abrir o pop-up de edição de usuário
  void _openEditUserPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                CustomInputField(
                  labelText: 'Nome:',
                  hintText: 'Digite seu nome',
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setState(() {
                      nomeedit = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                CustomInputField(
                  labelText: 'Senha:',
                  hintText: 'Digite sua senha',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    senhaedit = value;
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Salvar',
                  onPressed: () async {
                    //Pega o usuario dessas coisas
                    List<Map<String, dynamic>> userfull =
                        await SQLUser.pegaUmUsuarioEmail(email, senha);
                    int id = userfull.first['id'];

                    //Transforma a senha em md5
                    String senhamd = generateMd5(senhaedit);

                    // Altera o usuário no banco de dados
                    await SQLUser.atualizaUsuario(
                        id,
                        nomeedit,
                        userfull.first['dataNasc'],
                        userfull.first['email'],
                        senhamd);

                    // Inicializa o SharedPreferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // Altera os tokens armazenados
                    Cipher cipher = Cipher();
                    nomeedit = cipher.xorEncode(nomeedit);
                    senhaedit = cipher.xorEncode(senhaedit);
                    await prefs.setString('nome', nomeedit);
                    await prefs.setString('senha', senhaedit);

                    Navigator.pop(context); // Fecha o diálogo
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Sair da Conta',
                  onPressed: () async {
                    // Inicializa o SharedPreferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    // Remove os tokens armazenados
                    await prefs.remove('email');
                    await prefs.remove('senha');
                    await prefs.remove('nome');

                    Navigator.pop(context); // Fecha o diálogo
                    Navigator.pushReplacementNamed(context, 'Login');
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Excluir Conta',
                  onPressed: () {
                    _openConfirmDeletePopup(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openConfirmDeletePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Text(
            'Tem certeza de que deseja excluir a conta?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Fecha apenas o pop-up de confirmação
                    },
                    child: Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // Ação para excluir a conta
                      List<Map<String, dynamic>> userfull =
                          await SQLUser.pegaUmUsuarioEmail(email, senha);
                      int id = userfull.first['id'];

                      await SQLUser.apagaUsuario(id);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      // Remove os tokens armazenados
                      await prefs.remove('email');
                      await prefs.remove('senha');
                      await prefs.remove('nome');

                      Navigator.pop(context); // Fecha o pop-up de confirmação
                      Navigator.pushReplacementNamed(context, 'Login');
                    },
                    child: Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _donation(nomeOng, data, valor) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Text(
                        nomeOng.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(75, 0, 0, 0)),
                      Text(
                        data.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    valor.toString(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
