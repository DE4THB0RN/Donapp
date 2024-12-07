import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage_ONGState extends StatefulWidget {
  const Loginpage_ONGState({super.key});

  @override
  State<Loginpage_ONGState> createState() => __Loginpage_ONGState();
}

class __Loginpage_ONGState extends State<Loginpage_ONGState> {
  late SharedPreferences prefs;

  String email = '';
  String senha = '';

  List<Map<String, dynamic>> _usuario = [];

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _pegarONG() async {
    _usuario = await SQLONG.pegaUmaONGEmail2(email);
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
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Entrar com Google',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Entrar',
                    onPressed: () async {
                      _initPrefs();
                      if (email.isEmpty || senha.isEmpty) {
                        Preencha.dialogo(context);
                      } else {
                        senha = generateMd5(senha);
                        //await _pegarONG();
                        //por questão de debug mudei o _usuario por esse usuarioTry, queria ver se era lá o problema, mas n era n kkkk
                        List<Map<String, dynamic>> usuarioTry =
                            await SQLONG.pegaUmaONGEmail2(email);
                        if (usuarioTry.isNotEmpty) {
                          String senhaDebug = usuarioTry.first['senha'];
                          String senhaTentando = senha;
                          print(senhaTentando);
                          print(senhaDebug);
                          if (usuarioTry.first['senha'] == senha) {
                            String nome = usuarioTry.first['nome'];
                            nome = cipher.xorEncode(nome);
                            prefs.setString('nome', nome);
                            String emailtoken = cipher.xorEncode(email);
                            prefs.setString('email', emailtoken);
                            String senhatoken = cipher.xorEncode(senha);
                            prefs.setString('senha', senhatoken);
                            prefs.setBool('is_ONG', true);
                            Navigator.pushReplacementNamed(context, 'Home');
                          } else {
                            _senhaErrada();
                          }
                        } else if (usuarioTry.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Erro'),
                                content: const Text('ONG não encontrada'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Criar conta',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Cadastro_ONG');
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Voltar',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Escolha');
                    },
                  ),
                  SizedBox(height: 20),
                  // Botão Voltar no final
                  CustomButton(
                    text: 'Voltar',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Escolha');
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
          title: const Text('Erro'),
          content: const Text('Senha incorreta'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
