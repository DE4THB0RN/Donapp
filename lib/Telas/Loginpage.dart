import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomButton.dart';



class _LoginpageState extends StatefulWidget {
  const _LoginpageState({super.key});

  @override
  State<_LoginpageState> createState() => __LoginpageState();
}

class __LoginpageState extends State<_LoginpageState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
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
                    // Atualiza o estado se necessário
                  },
                ),
                SizedBox(height: 15),
                CustomInputField(
                  labelText: 'Senha:',
                  hintText: 'Digite sua senha:',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    // Atualiza o estado se necessário
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
                  text: 'Registrar',
                  onPressed: () {
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
    );
  }
}
