import 'dart:convert';

import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_donate.dart';
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
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
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

  Ongclass objetoONG = Ongclass.ongClassNull();
  int? idLogado = 0;
  List<Localclass> localidades = [];
  List<LocalCard> localCards = [];
  List<Postclass> postagens = [];
  List<Postcard> postCards = [];
  bool isOng = false;
  double valor = 0.0;
  String editbanner = '';
  String editperfil = '';
  String editdescricao = '';
  String editnome = '';
  String editemail = '';
  String editsenha = '';
  String postTitulo = '';
  String postComent = '';
  String postImage = '';

  void createOng(int id) async {
    List<Map<String, dynamic>> ongFull = await SQLONG.pegaUmaONG(id);
    List<Map<String, dynamic>> locais = await SQLLocal.pegaLocaisOng(id);
    List<Map<String, dynamic>> posts = await SqlPost.pegaPostsOng(id);
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
                            _openHistoricoPopup(context);
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
                      if(isOwnONG) ...[
                        ButtonEdited(
                          icon: Icons.add,
                          label: 'Adicionar Local',
                          onPressed: () {
                            print("Adicionar Local");
                          },
                        ),
                      ],
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
                                onPressed: () {
                                  print("Editar postagem");
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  print("Deletar postagem");
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
                const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Nome:',
                      hintText: 'Digite o Nome no cartão',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editemail = value;
                      },
                      onSubmitted: (value) {},
                    ),
                const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Cartão:',
                      hintText: 'Digite o Numero do Cartão',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editemail = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Data de expiração:',
                      hintText: 'Digite a data de expiração',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editemail = value;
                      },
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      labelText: 'Data de expiração:',
                      hintText: 'Digite a data de expiração',
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      onChanged: (value) {
                        editemail = value;
                      },
                      onSubmitted: (value) {},
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
                        List<Map<String, dynamic>> ONG =
                            await SQLONG.pegaUmaONG(objetoONG.id);

                        for (dynamic i in ONG) {
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
                          editsenha = ONG.first['senha'];
                        }
                        if (editemail.isEmpty) {
                          editemail = ONG.first['email'];
                        }
                        await SQLONG.atualizaONG(
                            objetoONG.id,
                            editnome,
                            ONG.first['cnpj'],
                            editemail,
                            generateMd5(editsenha),
                            editdescricao,
                            editperfil,
                            editbanner);

                        objetoONG.nome = editnome;
                        objetoONG.desc = editdescricao;
                        objetoONG.banner = editbanner;
                        objetoONG.perfil = editperfil;

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
                        await prefs.setBool('is_ONG', false);

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
        await prefs.setBool('is_ONG', false);
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
                          DoacaoCard(dia: "26/11", valor: 1234.56),
                          DoacaoCard(dia: "25/11", valor: 567.89),
                          DoacaoCard(dia: "24/11", valor: 34.50),
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
}
