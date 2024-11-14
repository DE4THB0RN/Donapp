import 'package:donapp/BD/cep_service.dart';
import 'package:donapp/BD/sql_ONG.dart';
import 'package:donapp/BD/sql_local_ONG.dart';
import 'package:donapp/Components/ImageInputField.dart';
import 'package:donapp/Components/LocalCard.dart';
import 'package:donapp/Components/Preencha.dart';
import 'package:donapp/Components/localClass.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:donapp/Theme/Padding.dart';
import 'package:flutter/material.dart';
import 'package:donapp/Components/CustomButton.dart';
import 'package:donapp/Components/CustomInputField.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cadastro2Ong extends StatefulWidget {
  @override
  _Cadastro2OngState createState() => _Cadastro2OngState();
}

class _Cadastro2OngState extends State<Cadastro2Ong> {
  late SharedPreferences prefs;

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String perfil = '';
  String banner = '';
  String email = '';
  String nome = '';
  String cnpj = '';
  String senha = '';
  String desc = '';
  List<Localclass> localidades = [];
  List<LocalCard> localCards = [];
  String cep = '';
  String rua = '';
  String complemento = '';
  String bairro = '';
  String cidade = '';
  String estado = '';

  TextEditingController controlRua = TextEditingController();
  TextEditingController controlBairro = TextEditingController();
  TextEditingController controlCidade = TextEditingController();
  TextEditingController controlEstado = TextEditingController();

  void _addLocalidade(Localclass localidade) {
    setState(() {
      localidades.add(localidade); // Adiciona um item vazio na lista
      localCards.add(LocalCard(
          rua: localidade.rua,
          bairro: localidade.bairro,
          complemento: localidade.complemento));
    });
  }

  void _retrieveData() {
    // Simulate data retrieval
    setState(() {
      controlRua.text = rua;
      controlBairro.text = bairro;
      controlCidade.text = cidade;
      controlEstado.text = estado;
    });
  }

  void _removeLocalidade(int index) {
    setState(() {
      // Remove o valor da lista de localidades e o controller correspondente
      localidades.removeAt(index);
      localCards.removeAt(index);
    });
  }

  // void _setarDados() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? emailtoken = prefs.getString('email');

  //   if (emailtoken != null) {
  //     setState(() {
  //       email = cipher.xorDecode(emailtoken);
  //     });
  //     List<Map<String, dynamic>> ONG = await SQLONG.pegaUmaONGEmail2(email);
  //     if (id == -1) {
  //       id = ONG.first['id'];
  //       email = ONG.first['email'];
  //       nome = ONG.first['nome'];
  //       cnpj = ONG.first['cnpj'];
  //       senha = ONG.first['senha'];
  //       desc = ONG.first['desc'];
  //     }
  //     await SQLONG.atualizaONG(
  //         id, nome, cnpj, email, senha, desc, perfil, banner);
  //     if (localidades.isNotEmpty) {
  //       for (dynamic i in localidades) {
  //         await SQLLocal.adicionarLocal(localidades[i], id);
  //       }
  //     }
  //   }
  // }

  void _openEditLocal(BuildContext context) {
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
                      icon: Icon(Icons.close, color: Colors.white),
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
                        cep = value;
                      });
                    },
                    onSubmitted: (value) async {
                      String endereco = await CepService.recuperaCep(cep);
                      if (endereco != "") {
                        List<String> dados = endereco.split("/");
                        setState(() {
                          rua = dados[0];
                          bairro = dados[2];
                          cidade = dados[3];
                          estado = dados[4];
                        });
                        _retrieveData();
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Cidade:',
                    hintText: 'Digite sua cidade',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      cidade = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlCidade,
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Rua:',
                    hintText: 'Digite sua rua',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      rua = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlRua,
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Complemento:',
                    hintText: 'Digite o complemento',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      complemento = value;
                    },
                    onSubmitted: (value) {},
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Bairro:',
                    hintText: 'Digite o bairro',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      bairro = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlBairro,
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    labelText: 'Estado:',
                    hintText: 'Digite o estado',
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      estado = value;
                    },
                    onSubmitted: (value) {},
                    controller: controlEstado,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Salvar',
                    onPressed: () async {
                      if (cidade.isEmpty ||
                          rua.isEmpty ||
                          bairro.isEmpty ||
                          estado.isEmpty ||
                          cep.isEmpty) {
                        Preencha.dialogo(context);
                      } else {
                        Localclass local;
                        if (complemento.isEmpty) {
                          local =
                              Localclass(cep, rua, '', bairro, cidade, estado);
                          _addLocalidade(local);
                        } else {
                          local = Localclass(
                              cep, rua, complemento, bairro, cidade, estado);
                          _addLocalidade(local);
                        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: Padinho.pequeno,
            child: Container(
              padding: Padinho.medio,
              decoration: BoxDecoration(
                color: AppColor.appBarColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                    SizedBox(height: 15),
                    Text(
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
                    SizedBox(height: 15),
                    Text(
                      'Localidades',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        for (int i = 0; i < localidades.length; i++)
                          Row(
                            children: [
                              Expanded(
                                child: localCards[i],
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeLocalidade(i),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Adicionar Localidade',
                      //onPressed: _addLocalidade,
                      onPressed: () {
                        setState(() {
                          cep = '';
                          rua = '';
                          complemento = '';
                          bairro = '';
                          cidade = '';
                          estado = '';
                        });
                        _retrieveData();
                        _openEditLocal(context);
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Terminar',
                      onPressed: () async {
                        String? email_ong = prefs.getString('email_ONG');
                        List<Map<String, dynamic>> ong_full =
                            await SQLONG.pegaUmaONGEmail2(email_ong!);
                        int id_ong = ong_full.first['id'];
                        nome = ong_full.first['nome'];
                        cnpj = ong_full.first['cnpj'];
                        email = ong_full.first['email'];
                        senha = ong_full.first['senha'];
                        desc = ong_full.first['desc'];
                        await SQLONG.atualizaONG(id_ong, nome, cnpj, email,
                            senha, desc, perfil, banner);

                        if (localidades.isNotEmpty) {
                          for (int i = 0; i < localidades.length; i++) {
                            await SQLLocal.adicionarLocal(
                                localidades[i].cep,
                                localidades[i].rua,
                                localidades[i].complemento,
                                localidades[i].bairro,
                                localidades[i].cidade,
                                localidades[i].estado,
                                id_ong);
                          }
                        }
                        Navigator.pushReplacementNamed(context, 'Home');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
