import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 2, 54, 97), // Cor de fundo para a área de inputs
              borderRadius: BorderRadius.circular(20.0), // Borda arredondada
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinhamento à esquerda
              children: [
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Cor branca para o texto
                    fontWeight: FontWeight.bold, // Deixa o texto mais visível
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.name, // Tipo de input para nome
                  decoration: InputDecoration(
                    hintText: 'EmailExemplo@email.com',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white, // Cor de fundo do input
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Senha:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Cor branca para o texto
                    fontWeight: FontWeight.bold, // Deixa o texto mais visível
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  obscureText: true, // Input para senha
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha:',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white, // Cor de fundo do input
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
                      style: TextStyle(color: Colors.white),
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
                      'Registrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Pequeno espaço entre os botões
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
                      style: TextStyle(color: Colors.white),
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
