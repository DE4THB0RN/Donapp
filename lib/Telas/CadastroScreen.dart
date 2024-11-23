import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomDateInputField.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

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
  String senhaconfirm = '';

  Future<void> _createUser() async {
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
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Confirme a senha:',
                      hintText: 'Digite sua senha novamente',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (value) {
                        senhaconfirm = value;
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
                            dataNascimento.isEmpty ||
                            senha.isEmpty) {
                          Preencha.dialogo(context);
                        } else if (senha != senhaconfirm) {
                          Preencha.senhaErrada(context);
                        } else {
                          senha = generateMd5(senha);
                          List<Map<String, dynamic>> userfull =
                              await SQLUser.pegaUmUsuarioEmail2(email);

                          if (userfull.isEmpty) {
                            await _createUser();
                            if (id != -1) {
                              if (_formKey.currentState!.validate()) {
                                String emailtoken = cipher.xorEncode(email);
                                prefs.setString('email', emailtoken);
                                String senhatoken = cipher.xorEncode(senha);
                                prefs.setString('senha', senhatoken);
                                String nometoken = cipher.xorEncode(nome);
                                prefs.setString('nome', nometoken);
                                prefs.setBool('is_ONG', false);
                                Navigator.pushReplacementNamed(context, 'Home');
                              }
                            }
                          } else {
                            Preencha.User_existente(context);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Já tenho conta',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Login_User');
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

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    String? emailtoken = prefs.getString('email');
    String? senhatoken = prefs.getString('senha');
    String? nometoken = prefs.getString('nome');

    if (emailtoken != null && senhatoken != null && nometoken != null) {
      Navigator.pushReplacementNamed(context, 'Home');
    }
  }
}
