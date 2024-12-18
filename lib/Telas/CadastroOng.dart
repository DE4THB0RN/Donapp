import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CadastroOng extends StatefulWidget {
  const CadastroOng({super.key});

  @override
  _CadastroOngState createState() => _CadastroOngState();
}

class _CadastroOngState extends State<CadastroOng> {
  late SharedPreferences prefs;

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String nome = '';
  String email = '';
  String CNPJ = '';
  String senha = '';

  Future<void> _createONG() async {
    id = await SQLONG.adicionarONG(nome, email, senha, CNPJ);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColor.appBarColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      labelText: 'Nome:',
                      hintText: 'NomeExemplo',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        setState(() {
                          nome = value;
                        });
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Email:',
                      hintText: 'EmailExemplo@email.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'CNPJ:',
                      hintText: 'XX.XXX.XXX/XXXX-XX',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          CNPJ = value;
                        });
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Senha:',
                      hintText: 'Digite sua senha:',
                      keyboardType: TextInputType.text,
                      obscureText:
                          true, // Define o campo de senha para ocultar o texto
                      onChanged: (value) {
                        setState(() {
                          senha = value;
                          print(senha);
                        });
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Registrar',
                      onPressed: () async {
                        _initPrefs();
                        if (nome.isEmpty ||
                            email.isEmpty ||
                            CNPJ.isEmpty ||
                            senha.isEmpty) {
                          Preencha.dialogo(context);
                        } else {
                          senha = generateMd5(senha);
                          List<Map<String, dynamic>> ONGfull =
                              await SQLONG.pegaUmaONGEmail2(email);

                          if (ONGfull.isEmpty) {
                            await _createONG();
                            if (id != -1) {
                              if (_formKey.currentState!.validate()) {
                                String emailtoken = cipher.xorEncode(email);
                                prefs.setString('email', emailtoken);
                                String senhatoken = cipher.xorEncode(senha);
                                prefs.setString('senha', senhatoken);
                                String nometoken = cipher.xorEncode(nome);
                                prefs.setString('nome', nometoken);
                                Navigator.pushReplacementNamed(
                                    context, 'Cadastro_ONG2');
                              }
                            }
                          } else {
                            Preencha.ONG_existente(context);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Já tenho conta',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Login_ONG');
                      },
                    ),
                    SizedBox(height: 10),
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
      ),
    );
  }
}
