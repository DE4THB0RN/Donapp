import 'package:donapp/Components/ImageInputField.dart';
import 'package:donapp/Theme/Color.dart';

import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cadastro2Ong extends StatefulWidget {
  @override
  _Cadastro2OngState createState() => _Cadastro2OngState();
}

class _Cadastro2OngState extends State<Cadastro2Ong> {
  late SharedPreferences prefs;

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String perfil = '';
  String banner = '';
  String CNPJ = '';
  String senha = '';
  

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
                    SizedBox(height: 15),
                    ImageInputField(
                      onImageSelected: (imageString) {
                        setState(() {
                          perfil = imageString; // Armazena a imagem em base64
                          print(perfil);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    ImageInputField(
                      onImageSelected: (imageString) {
                        setState(() {
                          banner = imageString; // Armazena a imagem em base64
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'CNPJ:',
                      hintText: 'XX. XXX. XXX/XXXX-XX.',
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          CNPJ = value;
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
                          print(senha);
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Registrar',
                      onPressed: () async {},
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

    if (emailtoken != null &&
        senhatoken != null &&
        nometoken != null &&
        nometoken != "blah blah blah") {
      Navigator.pushReplacementNamed(context, 'Home');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Cadastro2Ong(),
  ));
}
