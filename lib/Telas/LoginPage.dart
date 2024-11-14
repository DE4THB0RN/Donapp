import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginpageState extends StatefulWidget {
  const LoginpageState({super.key});

  @override
  State<LoginpageState> createState() => __LoginpageState();
}

class __LoginpageState extends State<LoginpageState> {
  late SharedPreferences prefs;

  String email = '';
  String senha = '';

  List<Map<String, dynamic>> _usuario = [];

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _pegarUser() async {
    _usuario = await SQLUser.pegaUmUsuarioEmail2(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: Padinho.medio,
            child: Container(
              padding: Padinho.medio,
              decoration: BoxDecoration(
                color:
                    AppColor.appBarColor, // Cor de fundo para a área de inputs
                borderRadius: BorderRadius.circular(20.0), // Borda arredondada
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    labelText: 'Email:',
                    hintText: 'EmailExemplo@email.com',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Senha:',
                    hintText: 'Digite sua senha:',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value) {
                      senha = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Entrar com Google',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Home');
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Entrar',
                    onPressed: () async {
                      _initPrefs();
                      if (email.isEmpty || senha.isEmpty) {
                        Preencha.dialogo(context);
                      } else {
                        senha = generateMd5(senha);
                        await _pegarUser();
                        if (_usuario.isNotEmpty) {
                          if (_usuario.first['senha'] == senha) {
                            String nome = _usuario.first['nome'];
                            nome = cipher.xorEncode(nome);
                            prefs.setString('nome', nome);
                            String emailtoken = cipher.xorEncode(email);
                            prefs.setString('email', emailtoken);
                            String senhatoken = cipher.xorEncode(senha);
                            prefs.setString('senha', senhatoken);
                            Navigator.pushReplacementNamed(context, 'Home');
                          } else {
                            _senhaErrada();
                          }
                        } else if (_usuario.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Erro'),
                                content: Text('Usuário não encontrado'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    text: 'Criar conta',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Cadastro');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _senhaErrada() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Senha incorreta'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
