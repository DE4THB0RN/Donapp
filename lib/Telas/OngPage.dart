import 'dart:convert';

import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/Components/CustomImputFiledMoney.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Components/ButtonEdited.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:donapp/Components/Helper.dart';

class Ongpage extends StatefulWidget {
  final int ongId;

  const Ongpage({super.key, required this.ongId});

  @override
  State<Ongpage> createState() => _OngpageState();
}

class _OngpageState extends State<Ongpage> {
  late SharedPreferences prefs;

  Ongclass objetoONG = Ongclass.ongClassNull();
  int? idLogado = 0;

  void createOng(int id) async {
    List<Map<String, dynamic>> ongFull = await SQLONG.pegaUmaONG(id);
    setState(() {
      objetoONG.banner = ongFull.first['foto_banner'];
      objetoONG.perfil = ongFull.first['foto_perfil'];
      objetoONG.desc = ongFull.first['desc'];
      objetoONG.nome = ongFull.first['nome'];
      objetoONG.id = id;
    });
  }

  @override
  void initState() {
    super.initState();
    createOng(widget.ongId);
    _carregarId();
  }

  Future<void> _carregarId() async {
    final int id = await _pegaId(); // Aguarda o ID
    setState(() {
      idLogado = id; // Atualiza o estado
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOwnONG = objetoONG.id == idLogado;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Stack para sobrepor elementos (Banner + Imagem principal)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(
                              objetoONG.banner)), // Imagem do banner
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Imagem principal sobreposta no centro
                Positioned(
                  top: 120, // Ajusta a posição vertical da imagem
                  left: 30,
                  child: Container(
                    width: 120, // Diâmetro do círculo
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Garante o formato circular
                      color: Colors.black, // Cor de fundo (borda)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1), // Espessura da borda
                      child: Container(
                        decoration: BoxDecoration(
                          shape:
                              BoxShape.circle, // Formato circular para a imagem
                          image: DecorationImage(
                            fit: BoxFit.cover, // Ajusta a imagem ao contêiner
                            image: MemoryImage(base64Decode(objetoONG.perfil)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 150,
                  top: 200,
                  child: Text(
                    objetoONG.nome,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Positioned(
                  left: 8,
                  top: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isOwnONG) ...[
                        // Botões quando for a própria ONG
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonEdited(
                              icon: Icons.edit,
                              label: 'Editar perfil',
                              onPressed: () {
                                print("Editar perfil");
                              },
                            ),
                            const SizedBox(width: 10), // Espaço entre os botões
                            ButtonEdited(
                              icon: Icons.post_add,
                              label: 'Fazer postagem',
                              onPressed: () {
                                print("Fazer postagem");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Espaço entre as linhas
                        ButtonEdited(
                          icon: Icons.history,
                          label: 'Histórico de doações',
                          onPressed: () {
                            print("Histórico de doações");
                          },
                        ),
                      ] else ...[
                        // Botões quando NÃO for a própria ONG
                        Row(
                          children: [
                            ButtonEdited(
                              icon: Icons.wallet_giftcard,
                              label: 'Doar',
                              onPressed: () {
                                print("Doar");
                              },
                            ),
                            const SizedBox(width: 10), // Espaço entre os botões
                            ButtonEdited(
                              icon: Icons.favorite,
                              label: 'Seguir',
                              onPressed: () {
                                print("Seguir!");
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Informações da ONG
            Padding(
              padding: Padinho.pequeno,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey, // Cor de fundo do container
                  borderRadius:
                      BorderRadius.circular(15), // Bordas arredondadas
                ),
                padding: const EdgeInsets.all(10),
                child: const Column(
                  children: [
                    Text(
                      'Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: Padinho.pequeno,
              child: FlutterCarousel(
                options: FlutterCarouselOptions(
                  height: 400.0,
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(),
                ),
                items: ['assets/dog1.png', 'assets/dog2.png', 'assets/dog3.png']
                    .map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          i,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            //Mapa
            Column(
              children: [
                const Text(
                  "Nossa Localização",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: Padinho.pequeno,
                  child: Container(
                    height: 450,
                    width: 450,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/mapa.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Publicações
            Padding(
              padding: Padinho.pequeno,
              child: Column(
                children: [
                  const Text(
                    "Publicações",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  buildCard('assets/dog1.png', 'Salvando animais!',
                      'Inaugurada em 2003, a Cão Viver é uma das ONGs mais conhecidas para a adoção de cães e gatos em BH.'),
                  buildCard('assets/dog2.png', 'Novos abrigos',
                      'Inauguramos novos abrigos para cães na localização X. Os novos abrigos tem capacidade para 400 cães'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _pegaId() async {
    final prefs = await SharedPreferences.getInstance();
    String? emailtoken = prefs.getString('email');
    String email = cipher.xorDecode(emailtoken!);

    int id = await SQLONG.pegaIdOng(email);
    print(id);
    return id;
  }
}

Widget buildCard(String imagePath, String title, String description) {
  return Padding(
    padding: Padinho.pequeno,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    ),
  );
}

void _openDoacaoPopup(BuildContext context) {
  final TextEditingController valorController = TextEditingController();
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.appBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Doação',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomInputFieldMoney(
                labelText: 'Valor da Doação',
                hintText: 'Digite o valor',
                keyboardType: TextInputType.number,
                controller: valorController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // Remove caracteres que não são números
                    String numericValue =
                        value.replaceAll(RegExp(r'[^0-9]'), '');
                    // Formata o valor como dinheiro
                    String formattedValue =
                        currencyFormat.format(int.parse(numericValue) / 100);
                    // Atualiza o controlador para exibir o valor formatado
                    valorController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                          offset: formattedValue.length),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String valor = valorController.text;
                  print('Valor da doação: $valor');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
