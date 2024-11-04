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
  final _formKey = GlobalKey<FormState>();
  int id = -1;
  String perfil = '';
  String banner = '';
  String CNPJ = '';
  String senha = '';
  List<String> localidades = [];
  List<TextEditingController> _controllers = []; // Lista de controladores para cada campo

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _addLocalidade() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _saveLocalidades() {
    localidades = _controllers.map((controller) => controller.text).toList();
    // Aqui, você pode salvar as localidades no banco de dados ou onde desejar.
    print(localidades); // Para verificar o conteúdo das localidades
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
                    SizedBox(height: 15),
                    ImageInputField(
                      onImageSelected: (imageString) {
                        setState(() {
                          perfil = imageString;
                        });
                      },
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
                    SizedBox(height: 15),
                    ImageInputField(
                      onImageSelected: (imageString) {
                        setState(() {
                          banner = imageString;
                        });
                      },
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
                      children: _controllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        TextEditingController controller = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: CustomInputField(
                            labelText: 'Localidade ${index + 1}',
                            hintText: 'Digite a localidade',
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              controller.text = value;
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Adicionar Localidade',
                      onPressed: _addLocalidade,
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Terminar',
                      onPressed: () {
                        _saveLocalidades();
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

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _checkLogin();
  }

  void _checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    String? emailtoken = prefs.getString('email');
    String? senhatoken = prefs.getString('senha');
    String? nometoken = prefs.getString('nome');

    if (emailtoken != null &&
        senhatoken != null &&
        nometoken != null &&
        nometoken != "blah blah blah") {
      Navigator.pushReplacementNamed(context, 'Home');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Cadastro2Ong(),
  ));
}
