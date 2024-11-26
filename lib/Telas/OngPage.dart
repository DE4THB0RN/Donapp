import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_donate.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomInputFieldMoney.dart';
import 'package:donapp/Components/ImageInputField.dart';
import 'package:donapp/Components/LocalCard.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Components/ButtonEdited.dart';
import 'package:donapp/Components/PostCard.dart';
import 'package:donapp/Components/localClass.dart';
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
  List<Localclass> localidades = [];
  List<LocalCard> localCards = [];
  bool isOng = false;
  double valor = 0.0;
  String banner = '';
  String perfil = '';
  String titulo = '';
  String coment = '';

  void createOng(int id) async {
    List<Map<String, dynamic>> ongFull = await SQLONG.pegaUmaONG(id);
    List<Map<String, dynamic>> locais = await SQLLocal.pegaLocaisOng(id);
    setState(() {
      objetoONG.banner = ongFull.first['foto_banner'];
      objetoONG.perfil = ongFull.first['foto_perfil'];
      objetoONG.desc = ongFull.first['desc'];
      objetoONG.nome = ongFull.first['nome'];
      objetoONG.id = id;

      for (dynamic i in locais) {
        localidades.add(Localclass(i['cep'], i['rua'], i['complemento'],
            i['numero'], i['bairro'], i['cidade'], i['estado']));
      }

      for (Localclass i in localidades) {
        localCards.add(LocalCard(
            rua: i.rua,
            bairro: i.bairro,
            numero: i.numero,
            complemento: i.complemento));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    createOng(widget.ongId);
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    bool? isOnger = prefs.getBool('is_ONG');
    if (isOnger != null) {
      setState(() {
        isOng = isOnger;
      });
    }
    if (isOng) {
      final int id = await _pegaId(); // Aguarda o ID
      setState(() {
        idLogado = id; // Atualiza o estado
      });
    }
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
              ],
            ),
            Column(
              children: [
                if (isOng) ...[
                  if (isOwnONG) ...[
                    // Botões quando for a própria ONG
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonEdited(
                              icon: Icons.edit,
                              label: 'Editar perfil',
                              onPressed: () {
                                _openEditONGPopup(context);
                              },
                            ),
                            const SizedBox(width: 10), // Espaço entre os botões
                            ButtonEdited(
                              icon: Icons.post_add,
                              label: 'Fazer postagem',
                              onPressed: () {
                                _openCreatePost(context);
                              },
                            ),
                          ],
                        ),
                        ButtonEdited(
                          icon: Icons.history,
                          label: 'Histórico de doações',
                          onPressed: () {
                            print("Histórico de doações");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Espaço entre as linhas
                  ]
                ] else ...[
                  Row(
                    children: [
                      ButtonEdited(
                        icon: Icons.wallet_giftcard,
                        label: 'Doar',
                        onPressed: () {
                          _openDoacaoPopup(context);
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
                ]
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
                Padding(
                  padding: Padinho.pequeno,
                  child: Column(
                    children: [
                      for (int i = 0; i < localidades.length; i++)
                        Row(
                          children: [
                            Expanded(
                              child: localCards[i],
                            ),
                          ],
                        ),
                    ],
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
                  Postcard(
                      imagePath: 'assets/dog1.png',
                      title: 'Salvando animais!',
                      description:
                          'Inaugurada em 2003, a Cão Viver é uma das ONGs mais conhecidas para a adoção de cães e gatos em BH.'),
                  Postcard(
                      imagePath: 'assets/dog2.png',
                      title: 'Novos abrigos',
                      description:
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
                  controller: valorController,
                  onChanged: (value) {
                    valor = UtilBrasilFields.converterMoedaParaDouble(value);
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

  Future<void> salvarDoacaoNoBanco(int idOng, int idUser, double valor) async {
    await SQLDonate.adicionarDonate(idOng, idUser, valor);
  }

  void _openEditONGPopup(BuildContext context) {
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
                  const Text(
                    'Imagem de Perfil',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ImageInputField(
                    onImageSelected: (imageString) {
                      setState(() {
                        perfil = imageString;
                      });
                    },
                    shape: ImageShape.circle,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Imagem do Banner',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ImageInputField(
                    onImageSelected: (imageString) {
                      setState(() {
                        banner = imageString;
                      });
                    },
                    shape: ImageShape.square,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openCreatePost(BuildContext context) {
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
                  const Text(
                    'Imagem do Post',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ImageInputField(
                    onImageSelected: (imageString) {
                      setState(() {
                        banner = imageString;
                      });
                    },
                    shape: ImageShape.square,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Titulo:',
                    hintText: 'Digite o Titulo',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value) {
                      titulo = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Descrição:',
                    hintText: 'Digite sua Descrição',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value) {
                      coment = value;
                    },
                    onSubmitted: (value) {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
