import 'package:donapp/Components/ImageInputField.dart';
import 'package:donapp/Theme/Color.dart';

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
  List<String> localidades = []; // Lista para armazenar os valores de cada localidade
  List<TextEditingController> _controllers = []; // Lista de controllers para os inputs

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String perfil = '';
  String banner = '';
  String CNPJ = '';
  String senha = '';

  void _addLocalidade() {
    setState(() {
      localidades.add(''); // Adiciona um item vazio na lista
      _controllers.add(TextEditingController()); // Cria um controller para o novo input
    });
  }

  void _removeLocalidade(int index) {
    setState(() {
      // Remove o valor da lista de localidades e o controller correspondente
      localidades.removeAt(index); 
      _controllers[index].dispose(); // Libera o controller removido
      _controllers.removeAt(index); 
      
      // Sincroniza os valores restantes dos controllers com a lista de localidades
      for (int i = 0; i < _controllers.length; i++) {
        localidades[i] = _controllers[i].text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
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
                                child: CustomInputField(
                                  labelText: 'Localidade ${i + 1}',
                                  hintText: 'Digite a localidade',
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    localidades[i] = value; // Atualiza a lista com o valor inserido
                                  },
                                  key: ValueKey(_controllers[i]), // Garante que o widget seja reconstruído corretamente
                                ),
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
                      onPressed: _addLocalidade,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Terminar',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'Login');
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

void main() {
  runApp(MaterialApp(
    home: Cadastro2Ong(),
  ));
}