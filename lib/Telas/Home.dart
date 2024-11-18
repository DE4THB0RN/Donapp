import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    _printaBD();
  }

  void _printaBD() async {
    List<Map<String, dynamic>> ONGfull = await SQLONG.pegaONGLimit();
    for (dynamic i in ONGfull) {
      print(i['nome']);
      print(i['senha']);
      print(i['cnpj']);
      print(i['email']);
      print(i['foto_perfil']);
      print(i['foto_banner']);
    }

    List<Map<String, dynamic>> Localfull = await SQLLocal.pegaLocal();
    for (dynamic i in Localfull) {
      print(i['cep']);
      print(i['rua']);
      print(i['complemento']);
      print(i['bairro']);
      print(i['cidade']);
      print(i['estado']);
      print(i['id_ong']);
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: Padinho.medio,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/dogfeliz.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'DESTAQUES',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seguidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                NGOCard(
                  title: 'ONG 1',
                  description: 'Somos uma ONG de ajudar animais',
                  image: 'assets/beagle.png',
                ),
                NGOCard(
                  title: 'ONG 2',
                  description: 'Doamos alimentos para os pobres',
                  image: 'assets/dog1.png',
                ),
                NGOCard(
                  title: 'ONG 3',
                  description: 'Somos uma ONG que doa roupas para os sem teto',
                  image: 'assets/dog2.png',
                ),
                NGOCard(
                  title: 'ONG 4',
                  description:
                      'Somos uma ONG que salva crianças em situação de fome e pobreza',
                  image: 'assets/dog3.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NGOCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  NGOCard(
      {required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
      onTap: () => {
        Navigator.pushReplacementNamed(
          context,
          'ONG',
          arguments: {'id': 1},
        ),
      },
    );
  }
}
