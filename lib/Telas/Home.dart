import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: Padinho.pequeno,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 250.0, // Altura fixa do carrossel
                viewportFraction: 1.0, // Cada slide ocupa 100% da largura
                enableInfiniteScroll: true, // Loop infinito
                autoPlay: true, // Reprodução automática
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false, // Não aumenta o slide central
              ),
              items: ['assets/dog1.png', 'assets/dog2.png', 'assets/dog3.png']
                  .map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width:
                          MediaQuery.of(context).size.width, // Largura da tela
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8.0), // Opcional: bordas arredondadas
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit
                              .cover, // Faz com que a imagem cubra toda a área
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
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

  @override
  void initState() {
    super.initState();
    _printaBD();
  }

  void _printaBD() async {
    List<Map<String, dynamic>> ONGfull = await SQLONG.pegaONGLimit();
    for (dynamic i in ONGfull) {
      print(i['id']);
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
      print(i['numero']);
      print(i['complemento']);
      print(i['bairro']);
      print(i['cidade']);
      print(i['estado']);
      print(i['id_ong']);
    }
  }
}

class NGOCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  NGOCard({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(
        context,
        'ONG',
        arguments: 1,
      ),
      child: SizedBox(
        width: double.infinity, // largura da tela
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // espaçamento interno
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8.0), // Bordas arredondadas na imagem
                  child: Image.asset(
                    image,
                    width: 130,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10), // espaço entre imagem e texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20, // ajuste do tamanho do texto
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
