import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donapp/Components/NGOCard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Ongclass> ONGS = [];
  List<NGOCard> CardsOng = [];

  void initializeCards() async {
    List<Map<String, dynamic>> ongFull = await SQLONG.pegaONG();
    setState(() {
      for (dynamic i in ongFull) {
        ONGS.add(Ongclass(i(['nome']), i(['desc']), i(['foto_banner']),
            i(['foto_perfil']), i(['id'])));
      }

      for (Ongclass i in ONGS) {
        CardsOng.add(NGOCard(
          title: i.nome,
          description: i.desc,
          image: i.perfil,
        ));
      }
    });
  }

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
                    return SizedBox(
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
                const Text(
                  'Seguidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    for (int i = 0; i < ONGS.length; i++)
                      Row(
                        children: [
                          Expanded(
                            child: CardsOng[i],
                          ),
                        ],
                      ),
                  ],
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

    // List<Map<String, dynamic>> Localfull = await SQLLocal.pegaLocal();
    // for (dynamic i in Localfull) {
    //   print(i['cep']);
    //   print(i['rua']);
    //   print(i['numero']);
    //   print(i['complemento']);
    //   print(i['bairro']);
    //   print(i['cidade']);
    //   print(i['estado']);
    //   print(i['id_ong']);
    // }
  }
}
