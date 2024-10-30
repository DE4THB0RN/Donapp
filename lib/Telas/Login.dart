import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.name, // Tipo de input para nome
                  decoration: InputDecoration(
                    hintText: 'EmailExemplo@email.com',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:
                        AppColor.backgroundColor, // Cor de fundo do input
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Senha:',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  obscureText:
                      true, // Input para senha, esconde o texto digitado
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha:',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.backgroundColor,
                  ),
                ),
                SizedBox(
                    height: 20), // Margem entre os campos de input e os botões
                SizedBox(
                  width: double
                      .infinity, // Faz o botão ocupar toda a largura disponível
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Home');
                    },
                    child: Text(
                      'Entrar com Google',
                      style: TextStyle(color: AppColor.backgroundColor),
                    ),
                  ),
                ),
                SizedBox(
                    height: 20), // Margem entre os campos de input e os botões
                SizedBox(
                  width: double
                      .infinity, // Faz o botão ocupar toda a largura disponível
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Home');
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(color: AppColor.backgroundColor),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double
                      .infinity, // Faz o botão ocupar toda a largura disponível
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Cadastro');
                    },
                    child: Text(
                      'Criar conta',
                      style: TextStyle(color: AppColor.backgroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
