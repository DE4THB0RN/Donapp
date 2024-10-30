import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomDateInputField.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  late SharedPreferences prefs;

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String nome = '';
  String email = '';
  String dataNascimento = '';
  String senha = '';
  final Cipher _cipher = Cipher();

  Future<void> _creando() async {
    id = await SQLUser.adicionarUsuario(nome, dataNascimento, email, senha);
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
                    ),
                    SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Email:',
                      hintText: 'EmailExemplo@email.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CustomDateInputField(
                      labelText: 'Data de Nascimento:',
                      hintText: 'Selecione a data de nascimento',
                      onDateSelected: (selectedDate) {
                        setState(() {
                          dataNascimento =
                              DateFormat("dd MMMM yyyy").format(selectedDate);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Senha:',
                      hintText: 'Digite sua senha:',
                      keyboardType: TextInputType.text,
                      obscureText:
                          true, // Define o campo de senha para ocultar o texto
                      onChanged: (value) {
                        setState(() {
                          senha = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Registrar',
                      onPressed: () {
                        _initPrefs();
                        if (nome.isEmpty ||
                            email.isEmpty ||
                            dataNascimento.isEmpty ||
                            senha.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Erro'),
                                content: Text('Preencha todos os campos'),
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
                        } else {
                          senha = generateMd5(senha);
                          _creando();
                          if (id != -1) {
                            if (_formKey.currentState!.validate()) {
                              String emailtoken = _cipher.xorEncode(email);
                              prefs.setString('email', emailtoken);
                              String senhatoken = _cipher.xorEncode(senha);
                              prefs.setString('senha', senhatoken);
                              Navigator.pushReplacementNamed(context, 'Home');
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Já tenho conta',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Login');
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
