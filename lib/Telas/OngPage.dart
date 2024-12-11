import 'dart:convert';

import 'package:donapp/BD/cep_service.dart';
import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_donate.dart';
import 'package:donapp/BD/sql_follow.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/BD/sql_post.dart';
import 'package:donapp/BD/sql_user.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Components/CustomInputFieldMoney.dart';
import 'package:donapp/Components/DoacaoCard.dart';
import 'package:donapp/Components/ImageInputField.dart';
import 'package:donapp/Components/LocalCard.dart';
import 'package:donapp/Components/OngClass.dart';
import 'package:donapp/Components/ButtonEdited.dart';
import 'package:donapp/Components/PostCard.dart';
import 'package:donapp/Components/PostClass.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Components/localClass.dart';
import 'package:donapp/Components/map.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:donapp/Components/Helper.dart';
import 'package:donapp/Components/confirmPoPup.dart';

class Ongpage extends StatefulWidget {
  final int ongId;

  const Ongpage({super.key, required this.ongId});

  @override
  State<Ongpage> createState() => _OngpageState();
}

class _OngpageState extends State<Ongpage> {
  late SharedPreferences prefs;
  final GlobalKey<MapSampleState> _mapKey = GlobalKey<MapSampleState>();

  Ongclass objetoONG = Ongclass.ongClassNull();
  int? idLogado = 0;
  List<Localclass> localidades = [];
  List<LocalCard> localCards = [];
  List<Postclass> postagens = [];
  List<Postcard> postCards = [];
  List<DoacaoCard> donateCards = [];
  bool isOng = false;
  bool isFollowing = false;
  double valor = 0.0;
  String editbanner = '';
  String editperfil = '';
  String editdescricao = '';
  String editnome = '';
  String editemail = '';
  String editsenha = '';
  String editcnpj = '';
  String postTitulo = '';
  String postComent = '';
  String postImage = '';
  String localcep = '';
  String localrua = '';
  int localnumero = 0;
  String localcomplemento = '';
  String localbairro = '';
  String localcidade = '';
  String localestado = '';
  int idPostToExclude = 0;
  int idLocalToExclude = 0;

  TextEditingController controlRua = TextEditingController();
  TextEditingController controlBairro = TextEditingController();
  TextEditingController controlCidade = TextEditingController();
  TextEditingController controlEstado = TextEditingController();

  void createOng(int id) async {
    List<Map<String, dynamic>> ongFull = await SQLONG.pegaUmaONG(id);
    List<Map<String, dynamic>> locais = await SQLLocal.pegaLocaisOng(id);
    List<Map<String, dynamic>> posts = await SqlPost.pegaPostsOng(id);
    List<Map<String, dynamic>> donates = await SQLDonate.pegaDonatesOng(id);
    setState(() {
      objetoONG.banner = ongFull.first['foto_banner'];
      objetoONG.perfil = ongFull.first['foto_perfil'];
      objetoONG.desc = ongFull.first['desc'];
      objetoONG.nome = ongFull.first['nome'];
      objetoONG.id = id;

      for (dynamic i in locais) {
        localidades.add(Localclass(i['cep'], i['rua'], i['complemento'],
            i['numero'], i['bairro'], i['cidade'], i['estado'], i['id']));
      }

      for (Localclass i in localidades) {
        localCards.add(LocalCard(
          rua: i.rua,
          bairro: i.bairro,
          numero: i.numero,
          complemento: i.complemento,
          id: i.id,
        ));
      }

      for (dynamic i in posts) {
        postagens
            .add(Postclass(i['titulo'], i['descricao'], i['imagem'], i['id']));
      }

      for (Postclass i in postagens) {
        postCards.add(Postcard(
          image: i.imagem,
          title: i.titulo,
          description: i.coment,
          id: i.id,
        ));
      }

      for (dynamic i in donates) {
        donateCards.add(DoacaoCard(dia: i['dataDonate'], valor: i['valor']));
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
    } else {
      String? emailUserTmp = prefs.getString('email');
      emailUserTmp = cipher.xorDecode(emailUserTmp!);
      List<Map<String, dynamic>> userTmp =
          await SQLUser.pegaUmUsuarioEmail2(emailUserTmp);
      int idUserTmp = userTmp.first['id'];
      List<Map<String, dynamic>> followTmp =
          await SQLFollow.pegafollowsUserOng(idUserTmp, widget.ongId);
      if (followTmp.isNotEmpty) {
        isFollowing = true;
      }
    }
    createOng(widget.ongId);
  }

  void _retrieveData() {
    // Simulate data retrieval
    setState(() {
      controlRua.text = localrua;
      controlBairro.text = localbairro;
      controlCidade.text = localcidade;
      controlEstado.text = localestado;
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
                  height: 250,
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
                            _openHistoricoPopup(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Espaço entre as linhas
                  ]
                ] else ...[
                  Padding(
                    padding: Padinho.pequeno,
                    child: Row(
                      children: [
                        ButtonEdited(
                          icon: Icons.wallet_giftcard,
                          label: 'Doar',
                          onPressed: () {
                            _openDoacaoPopup(context);
                          },
                        ),
                        const SizedBox(width: 10), // Espaço entre os botões
                        if (!isFollowing) ...[
                          ButtonEdited(
                            icon: Icons.favorite,
                            label: 'Seguir',
                            onPressed: () async {
                              String? emailUserTmp = prefs.getString('email');
                              emailUserTmp = cipher.xorDecode(emailUserTmp!);
                              List<Map<String, dynamic>> userTmp =
                                  await SQLUser.pegaUmUsuarioEmail2(
                                      emailUserTmp);
                              int idUserTmp = userTmp.first['id'];
                              await SQLFollow.adicionarFollow(
                                  idUserTmp, widget.ongId);
                              setState(() {
                                isFollowing = true;
                              });
                            },
                          ),
                        ] else ...[
                          ButtonEdited(
                            icon: Icons.favorite,
                            label: 'Seguindo',
                            onPressed: () async {
                              String? emailUserTmp = prefs.getString('email');
                              emailUserTmp = cipher.xorDecode(emailUserTmp!);
                              List<Map<String, dynamic>> userTmp =
                                  await SQLUser.pegaUmUsuarioEmail2(
                                      emailUserTmp);
                              int idUserTmp = userTmp.first['id'];
                              List<Map<String, dynamic>> followTmp =
                                  await SQLFollow.pegafollowsUserOng(
                                      idUserTmp, widget.ongId);
                              await SQLFollow.apagaFollow(
                                  followTmp.first['id']);
                              setState(() {
                                isFollowing = false;
                              });
                            },
                          ),
                        ]
                      ],
                    ),
                  )
                ]
              ],
            ),

            // Informações da ONG
            Padding(
              padding: Padinho.pequeno,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey, // Cor de fundo do container
                  borderRadius:
                      BorderRadius.circular(15), // Bordas arredondadas
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      objetoONG.desc,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: Padinho.pequeno,
            //   child: CarouselSlider(
            //     options: CarouselOptions(
            //       height: 300.0, // Altura fixa do carrossel
            //       viewportFraction: 0.8, // Cada slide ocupa 100% da largura
            //       enableInfiniteScroll: true, // Loop infinito
            //       autoPlay: false, // Reprodução automática
            //       autoPlayInterval: const Duration(seconds: 3),
            //       enlargeCenterPage: false, // Não aumenta o slide central
            //     ),
            //     items: ['assets/dog1.png', 'assets/dog2.png', 'assets/dog3.png']
            //         .map((imagePath) {
            //       return Builder(
            //         builder: (BuildContext context) {
            //           return Container(
            //             margin: const EdgeInsets.symmetric(horizontal: 8.0),
            //             width: MediaQuery.of(context)
            //                 .size
            //                 .width, // Largura da tela
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(8.0),
            //               child: Image.asset(
            //                 imagePath,
            //                 fit: BoxFit
            //                     .cover, // Faz com que a imagem cubra toda a área
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }).toList(),
            //   ),
            // ),

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
                  child: MapSample(
                    key: _mapKey,
                    height: 450, // Altura personalizada
                    width: 450, // Largura personalizada
                  ),
                ),
                Padding(
                  padding: Padinho.pequeno,
                  child: Column(
                    children: [
                      if (isOwnONG) ...[
                        ButtonEdited(
                          icon: Icons.add,
                          label: 'Adicionar Local',
                          onPressed: () {
                            _openCreateLocal(context);
                          },
                        ),
                      ],
                      for (int i = 0; i < localidades.length; i++)
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  String address = localidades[i].cep +
                                      ' ' +
                                      localidades[i].estado +
                                      ' ' +
                                      localidades[i].cidade +
                                      ' ' +
                                      localidades[i].bairro +
                                      ' ' +
                                      localidades[i].rua +
                                      ' ' +
                                      localidades[i].numero.toString();
                                  print(address);
                                  _mapKey.currentState?.moveToAddress(address);
                                },
                                child: localCards[i],
                              ),
                            ),
                            if (isOwnONG) ...[
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.lightBlue,
                                    onPressed: () async {
                                      List<Map<String, dynamic>> lugar =
                                          await SQLLocal.pegaUmLocalId(
                                              localCards[i].id);
                                      Localclass editlocal = Localclass(
                                          lugar.first['cep'],
                                          lugar.first['rua'],
                                          lugar.first['complemento'],
                                          lugar.first['numero'],
                                          lugar.first['bairro'],
                                          lugar.first['cidade'],
                                          lugar.first['estado'],
                                          lugar.first['id']);

                                      _openEditLocal(context, editlocal);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () async {
                                      List<Map<String, dynamic>> local =
                                          await SQLLocal.pegaUmLocalId(
                                              localCards[i].id);
                                      setState(() {
                                        idLocalToExclude = local.first['id'];
                                      });

                                      _openConfirmDeleteLocal(
                                          context, idLocalToExclude);
                                    },
                                  ),
                                ],
                              ),
                            ],
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
                  for (int i = 0; i < postagens.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: postCards[i],
                        ),
                        if (isOwnONG) ...[
                          SizedBox(width: 8),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.lightBlue,
                                onPressed: () async {
                                  List<Map<String, dynamic>> post =
                                      await SqlPost.pegaUmPostId(
                                          postCards[i].id);
                                  Postclass editPost = Postclass(
                                      post.first['titulo'],
                                      post.first['descricao'],
                                      post.first['imagem'],
                                      post.first['id']);
                                  _openEditPost(context, editPost);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  List<Map<String, dynamic>> post =
                                      await SqlPost.pegaUmPostId(
                                          postCards[i].id);
                                  setState(() {
                                    idPostToExclude = post.first['id'];
                                  });
                                  _openConfirmDeletePost(
                                      context, idPostToExclude);
                                },
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
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

  void _openEditLocal(BuildContext context, Localclass localedit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: Padinho.medio,
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
                  CustomInputField(
                    labelText: 'CEP:',
                    hintText: 'XXXXX-XXX',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        localcep = value;
                      });
                    },
                    onSubmitted: (value) async {
                      String endereco = await CepService.recuperaCep(localcep);
                      if (endereco != "") {
                        List<String> dados = endereco.split("/");
                        setState(() {
                          localrua = dados[0];
                          localbairro = dados[2];
                          localcidade = dados[3];
                          localestado = dados[4];
                        });
                        _retrieveData();
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Cidade:',
                    hintText: 'Digite sua cidade',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localcidade = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlCidade,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Rua:',
                    hintText: 'Digite sua rua',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localrua = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlRua,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Número:',
                    hintText: 'Digite o número',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      localnumero = int.parse(value);
                    },
                    onSubmitted: (value) {},
                  ),
                  CustomInputField(
                    labelText: 'Complemento:',
                    hintText: 'Digite o complemento',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localcomplemento = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Bairro:',
                    hintText: 'Digite o bairro',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localbairro = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlBairro,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Estado:',
                    hintText: 'Digite o estado',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localestado = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlEstado,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Salvar',
                    onPressed: () async {
                      if (localcep.isEmpty) {
                        localcep = localedit.cep;
                      }
                      if (localcidade.isEmpty) {
                        localcidade = localedit.cidade;
                      }
                      if (localrua.isEmpty) {
                        localrua = localedit.rua;
                      }
                      if (localbairro.isEmpty) {
                        localbairro = localedit.bairro;
                      }
                      if (localestado.isEmpty) {
                        localestado = localedit.estado;
                      }
                      if (localnumero == 0) {
                        localnumero = localedit.numero;
                      }
                      if (localcomplemento.isEmpty) {
                        localcomplemento = localedit.complemento;
                      }
                      await SQLLocal.atualizaLocal(
                          widget.ongId,
                          localedit.id,
                          localcep,
                          localrua,
                          localcomplemento,
                          localnumero,
                          localbairro,
                          localcidade,
                          localestado);

                      // Recarregar os locais e atualizar as listas
                      List<Map<String, dynamic>> locaisAtualizados =
                          await SQLLocal.pegaLocaisOng(widget.ongId);

                      setState(() {
                        localidades.clear();
                        localCards.clear();

                        for (var local in locaisAtualizados) {
                          Localclass novoLocal = Localclass(
                              local['cep'],
                              local['rua'],
                              local['complemento'],
                              local['numero'],
                              local['bairro'],
                              local['cidade'],
                              local['estado'],
                              local['id']);
                          localidades.add(novoLocal);
                          localCards.add(LocalCard(
                              rua: novoLocal.rua,
                              bairro: novoLocal.bairro,
                              numero: novoLocal.numero,
                              complemento: novoLocal.complemento,
                              id: novoLocal.id));
                        }

                        localcep = '';
                        localrua = '';
                        localcomplemento = '';
                        localnumero = 0;
                        localbairro = '';
                        localcidade = '';
                        localestado = '';
                      });
                      //fim do metodo de atualizar (debug)

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openDoacaoPopup(BuildContext context) {
    final TextEditingController valorController = TextEditingController();

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
                    valor = value / 100;
                    print("doação é $valor reais");
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (valor == 0.0) {
                      Preencha.donationZero(context);
                    } else {
                      _openConfirmDonationPopup(context);
                    }
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

  void _openEditONGPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: AppColor.appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                          editperfil = imageString;
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
                          editbanner = imageString;
                        });
                      },
                      shape: ImageShape.square,
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Nome:',
                      hintText: 'Digite o Nome da Ong',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editnome = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Descrição:',
                      hintText: 'Digite a descrição da Ong',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editdescricao = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'CNPJ:',
                      hintText: 'Digite o novo CNPJ',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editcnpj = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Senha:',
                      hintText: 'Digite a nova senha',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (value) {
                        editsenha = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Email:',
                      hintText: 'Digite o novo email',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editemail = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Salvar',
                      onPressed: () async {
                        List<Map<String, dynamic>> ong =
                            await SQLONG.pegaUmaONG(objetoONG.id);

                        for (dynamic i in ong) {
                          print(i['id']);
                          print(i['nome']);
                          print(i['senha']);
                          print(i['cnpj']);
                          print(i['email']);
                          print(i['foto_perfil']);
                          print(i['foto_banner']);
                        }

                        if (editnome.isEmpty) {
                          editnome = objetoONG.nome;
                        }
                        if (editdescricao.isEmpty) {
                          editdescricao = objetoONG.desc;
                        }
                        if (editbanner.isEmpty) {
                          editbanner = objetoONG.banner;
                        }
                        if (editperfil.isEmpty) {
                          editperfil = objetoONG.perfil;
                        }
                        if (editsenha.isEmpty) {
                          editsenha = ong.first['senha'];
                        }
                        if (editemail.isEmpty) {
                          editemail = ong.first['email'];
                        }
                        if (editcnpj.isEmpty) {
                          editcnpj = ong.first['cnpj'];
                        }
                        await SQLONG.atualizaONG(
                            objetoONG.id,
                            editnome,
                            editcnpj,
                            editemail,
                            generateMd5(editsenha),
                            editdescricao,
                            editperfil,
                            editbanner);

                        objetoONG.nome = editnome;
                        objetoONG.desc = editdescricao;
                        objetoONG.banner = editbanner;
                        objetoONG.perfil = editperfil;

                        String nomeToken = cipher.xorEncode(editnome);
                        prefs.setString('nome', nomeToken);
                        String emailtoken = cipher.xorEncode(editemail);
                        prefs.setString('email', emailtoken);
                        String senhatoken =
                            cipher.xorEncode(generateMd5(editsenha));
                        prefs.setString('senha', senhatoken);

                        editbanner = '';
                        editperfil = '';
                        editdescricao = '';
                        editnome = '';
                        editemail = '';
                        editsenha = '';
                        editcnpj = '';

                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Sair da conta',
                      onPressed: () async {
                        // Remove os tokens armazenados
                        await prefs.remove('email');
                        await prefs.remove('senha');
                        await prefs.remove('nome');
                        await prefs.remove('is_ONG');

                        Navigator.pop(context); // Fecha o pop-up de confirmação
                        Navigator.pushReplacementNamed(context, 'Escolha');
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Excluir conta',
                      onPressed: () async {
                        _openConfirmDeletePopup();
                      },
                    ),
                  ],
                ),
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
                        postImage = imageString;
                      });
                    },
                    shape: ImageShape.square,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Titulo:',
                    hintText: 'Digite o Titulo',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    onChanged: (value) {
                      postTitulo = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Descrição:',
                    hintText: 'Digite sua Descrição',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    onChanged: (value) {
                      postComent = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Postar',
                    onPressed: () async {
                      if (postComent.isEmpty ||
                          postImage.isEmpty ||
                          postTitulo.isEmpty) {
                        Preencha.dialogo(context);
                      } else {
                        await SqlPost.adicionarPost(
                            postTitulo, postComent, postImage, widget.ongId);

                        // Recarregar os posts e atualizar as listas
                        List<Map<String, dynamic>> postsAtualizados =
                            await SqlPost.pegaPostsOng(widget.ongId);

                        setState(() {
                          postagens.clear();
                          postCards.clear();

                          for (var post in postsAtualizados) {
                            Postclass novoPost = Postclass(post['titulo'],
                                post['descricao'], post['imagem'], post['id']);
                            postagens.add(novoPost);
                            postCards.add(Postcard(
                              image: novoPost.imagem,
                              title: novoPost.titulo,
                              description: novoPost.coment,
                              id: novoPost.id,
                            ));
                          }

                          postImage = '';
                          postTitulo = '';
                          postComent = '';
                        });
                        //fim do metodo de atualizar (debug)

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openEditPost(BuildContext context, Postclass postatual) {
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
                        postImage = imageString;
                      });
                    },
                    shape: ImageShape.square,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Titulo:',
                    hintText: 'Digite o Titulo',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    onChanged: (value) {
                      postTitulo = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Descrição:',
                    hintText: 'Digite sua Descrição',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    onChanged: (value) {
                      postComent = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Atualizar Post',
                    onPressed: () async {
                      if (postComent.isEmpty) {
                        postComent = postatual.coment;
                      }
                      if (postImage.isEmpty) {
                        postImage = postatual.imagem;
                      }
                      if (postTitulo.isEmpty) {
                        postTitulo = postatual.titulo;
                      }
                      await SqlPost.atualizaPost(postatual.id, postTitulo,
                          postComent, postImage, widget.ongId);

                      // Recarregar os posts e atualizar as listas
                      List<Map<String, dynamic>> postsAtualizados =
                          await SqlPost.pegaPostsOng(widget.ongId);

                      setState(() {
                        postagens.clear();
                        postCards.clear();

                        for (var post in postsAtualizados) {
                          Postclass atualizadoPost = Postclass(post['titulo'],
                              post['descricao'], post['imagem'], post['id']);
                          postagens.add(atualizadoPost);
                          postCards.add(Postcard(
                            image: atualizadoPost.imagem,
                            title: atualizadoPost.titulo,
                            description: atualizadoPost.coment,
                            id: atualizadoPost.id,
                          ));
                        }

                        postImage = '';
                        postTitulo = '';
                        postComent = '';
                      });
                      //fim da parada

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openConfirmDonationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: const Text(
            'Deseja mesmo fazer a doação?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Fecha apenas o pop-up de confirmação
                    },
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      print('Hora de pagar');
                      // Ação para sumir com esse popup de bomba
                      String emailUser =
                          cipher.xorDecode(prefs.getString('email')!);
                      List<Map<String, dynamic>> User =
                          await SQLUser.pegaUmUsuarioEmail2(emailUser);
                      int userID = User.first['id'];
                      DateTime time = DateTime.now();
                      String diaDonate =
                          DateFormat("dd MMMM yyyy").format(time);
                      await SQLDonate.adicionarDonate(
                          widget.ongId, userID, valor, diaDonate);
                      valor = 0.0;
                      Navigator.pop(context);
                      Navigator.pop(context); // Fecha o pop-up de confirmação
                      Preencha.donationSuccess(context);
                    },
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openConfirmDeletePost(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: const Text(
            'Deseja mesmo deletar o post',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Fecha apenas o pop-up de confirmação
                    },
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      print('Hora de apagar');
                      await SqlPost.apagaPost(postId);

                      // Recarregar os posts e atualizar as listas
                      List<Map<String, dynamic>> postsAtualizados =
                          await SqlPost.pegaPostsOng(widget.ongId);

                      setState(() {
                        postagens.clear();
                        postCards.clear();

                        for (var post in postsAtualizados) {
                          Postclass novoPost = Postclass(post['titulo'],
                              post['descricao'], post['imagem'], post['id']);
                          postagens.add(novoPost);
                          postCards.add(Postcard(
                            image: novoPost.imagem,
                            title: novoPost.titulo,
                            description: novoPost.coment,
                            id: novoPost.id,
                          ));
                        }
                      });
                      //fim do metodo de atualizar (debug)

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openConfirmDeleteLocal(BuildContext context, int localId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: const Text(
            'Deseja mesmo deletar a localização?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Fecha apenas o pop-up de confirmação
                    },
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // Cor de fundo para o botão "Sim"
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      print('Hora de apagar');
                      await SQLLocal.apagaLocal(localId);

                      // Recarregar os locais e atualizar as listas
                      List<Map<String, dynamic>> locaisAtualizados =
                          await SQLLocal.pegaLocaisOng(widget.ongId);

                      setState(() {
                        localidades.clear();
                        localCards.clear();

                        for (var local in locaisAtualizados) {
                          Localclass novoLocal = Localclass(
                              local['cep'],
                              local['rua'],
                              local['complemento'],
                              local['numero'],
                              local['bairro'],
                              local['cidade'],
                              local['estado'],
                              local['id']);
                          localidades.add(novoLocal);
                          localCards.add(LocalCard(
                              rua: novoLocal.rua,
                              bairro: novoLocal.bairro,
                              numero: novoLocal.numero,
                              complemento: novoLocal.complemento,
                              id: novoLocal.id));
                        }
                      });
                      //fim do metodo de atualizar (debug)

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openConfirmDeletePopup() async {
    await showConfirmDialog(
      context: context,
      message: 'Tem certeza de que deseja excluir a conta?',
      onConfirm: () async {
        print('Hora de apagar');
        String emailONG = cipher.xorDecode(prefs.getString('email')!);
        List<Map<String, dynamic>> ONG =
            await SQLONG.pegaUmaONGEmail2(emailONG);
        int ongID = ONG.first['id'];

        await SQLONG.apagaONG(ongID);

        List<Map<String, dynamic>> locaisList =
            await SQLLocal.pegaLocaisOng(ongID);

        for (dynamic i in locaisList) {
          await SQLLocal.apagaLocal(i['id']);
        }

        // Remove os tokens armazenados
        await prefs.remove('email');
        await prefs.remove('senha');
        await prefs.remove('nome');
        await prefs.remove('is_ONG');
        // print('apagado');

        Navigator.pop(context); // Fecha o pop-up de confirmação
        Navigator.pushReplacementNamed(context, 'Escolha');
      },
      onCancel: () {
        print('Exclusão cancelada.');
        Navigator.pop(context);
      },
    );
  }

  void _openHistoricoPopup(BuildContext context) {
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
                    'Histórico de Doações',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "totalArrecadado",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Arrecadados',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < donateCards.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: donateCards[i],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openCreateLocal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.appBarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: Padinho.medio,
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
                  CustomInputField(
                    labelText: 'CEP:',
                    hintText: 'XXXXX-XXX',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        localcep = value;
                      });
                    },
                    onSubmitted: (value) async {
                      String endereco = await CepService.recuperaCep(localcep);
                      if (endereco != "") {
                        List<String> dados = endereco.split("/");
                        setState(() {
                          localrua = dados[0];
                          localbairro = dados[2];
                          localcidade = dados[3];
                          localestado = dados[4];
                        });
                        _retrieveData();
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Cidade:',
                    hintText: 'Digite sua cidade',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localidades = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlCidade,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Rua:',
                    hintText: 'Digite sua rua',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localrua = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlRua,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Número:',
                    hintText: 'Digite o número',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      localnumero = int.parse(value);
                    },
                    onSubmitted: (value) {},
                  ),
                  CustomInputField(
                    labelText: 'Complemento:',
                    hintText: 'Digite o complemento',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localcomplemento = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Bairro:',
                    hintText: 'Digite o bairro',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localbairro = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlBairro,
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Estado:',
                    hintText: 'Digite o estado',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      localestado = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlEstado,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Salvar',
                    onPressed: () async {
                      if (localcidade.isEmpty ||
                          localrua.isEmpty ||
                          localbairro.isEmpty ||
                          localestado.isEmpty ||
                          localcep.isEmpty ||
                          localnumero == 0) {
                        Preencha.dialogo(context);
                      } else {
                        if (localcomplemento.isEmpty) {
                          await SQLLocal.adicionarLocal(
                              localcep,
                              localrua,
                              '',
                              localnumero,
                              localbairro,
                              localcidade,
                              localestado,
                              widget.ongId);
                        } else {
                          await SQLLocal.adicionarLocal(
                              localcep,
                              localrua,
                              localcomplemento,
                              localnumero,
                              localbairro,
                              localcidade,
                              localestado,
                              widget.ongId);
                        }

                        // Recarregar os locais e atualizar as listas
                        List<Map<String, dynamic>> locaisAtualizados =
                            await SQLLocal.pegaLocaisOng(widget.ongId);

                        setState(() {
                          localidades.clear();
                          localCards.clear();

                          for (var local in locaisAtualizados) {
                            Localclass novoLocal = Localclass(
                                local['cep'],
                                local['rua'],
                                local['complemento'],
                                local['numero'],
                                local['bairro'],
                                local['cidade'],
                                local['estado'],
                                local['id']);
                            localidades.add(novoLocal);
                            localCards.add(LocalCard(
                                rua: novoLocal.rua,
                                bairro: novoLocal.bairro,
                                numero: novoLocal.numero,
                                complemento: novoLocal.complemento,
                                id: novoLocal.id));
                          }

                          localcep = '';
                          localrua = '';
                          localcomplemento = '';
                          localnumero = 0;
                          localbairro = '';
                          localcidade = '';
                          localestado = '';
                        });
                        //fim do metodo de atualizar (debug)

                        Navigator.pop(context); // Fecha o diálogo
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
