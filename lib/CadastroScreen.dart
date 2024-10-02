import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
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
                  'Nome:',
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
                    hintText: 'NomeExemplo',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white, // Cor de fundo do input
                  ),
                ),
                SizedBox(height: 15),
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
                  keyboardType:
                      TextInputType.emailAddress, // Tipo de input para email
                  decoration: InputDecoration(
                    hintText: 'EmailExemplo@email.com',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white, // Cor de fundo do input
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Idade:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Cor branca para o texto
                    fontWeight: FontWeight.bold, // Deixa o texto mais visível
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType:
                      TextInputType.number, // Tipo de input para idade
                  decoration: InputDecoration(
                    hintText: 'IdadeExemplo',
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
                SizedBox(height: 20), // Margem entre o input e os botões
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
                  width: double.infinity, // Ocupar a maioria da tela
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'Login');
                    },
                    child: Text(
                      'Já tenho conta',
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

void main() {
  runApp(MaterialApp(
    home: CadastroScreen(),
  ));
}
