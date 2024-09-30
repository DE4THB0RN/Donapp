import 'package:flutter/material.dart';

class Ongpage extends StatefulWidget {
  const Ongpage({super.key});

  @override
  State<Ongpage> createState() => _OngpageState();
}

class _OngpageState extends State<Ongpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Stack para sobrepor elementos (Banner + Imagem principal)
          Stack(
            alignment: Alignment.center, // Centraliza a imagem principal
            children: [
              Container(
                height: 250,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/dogfeliz.png'), // Imagem do banner
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Imagem principal sobreposta no centro
              Positioned(
                top: 120, // Ajusta a posição vertical da imagem
                left: 20,
                child: CircleAvatar(
                  radius: 60, // Tamanho da imagem
                  backgroundColor: Colors.black, //color
                  child: Padding(
                    padding: const EdgeInsets.all(1), // Border radius
                    child: ClipOval(child: Image.asset('assets/beagle.png')),
                  ),
                ),
              ),

              Positioned(
                  bottom: 0,
                  right: 40,
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Ação para o botão de seguir
                        },
                        icon: Icon(Icons.favorite),
                        label: Text('Seguir'),
                      ),
                      SizedBox(width: 20),
                      Text('ONG 1',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ))
            ],
          ),

          SizedBox(height: 20), // Espaçamento para ajustar abaixo do banner

          // Informações da ONG
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber, // Cor de fundo do container
                borderRadius: BorderRadius.circular(15), // Bordas arredondadas
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Primeira imagem
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage('assets/dog1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Segunda imagem
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage('assets/dog2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Terceira imagem
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage('assets/dog3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
