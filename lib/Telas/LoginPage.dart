import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
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
              color: AppColor.appBarColor, // Cor de fundo para a área de inputs
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
                  onPressed: () {
                    _initPrefs();
                    Navigator.pushReplacementNamed(context, 'Home');
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
}
