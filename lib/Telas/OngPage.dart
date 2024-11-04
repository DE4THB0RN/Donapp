import 'package:donapp/Components/CustomImputFiledMoney.dart';
import 'package:donapp/Components/CustomInputField.dart';
import 'package:donapp/Theme/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:intl/intl.dart';

class Ongpage extends StatefulWidget {
  const Ongpage({super.key});

  @override
  State<Ongpage> createState() => _OngpageState();
}

class _OngpageState extends State<Ongpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Stack para sobrepor elementos (Banner + Imagem principal)
            Stack(
              alignment: Alignment.center, // Centraliza a imagem principal
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
                          image: AssetImage(
                              'assets/dogfeliz.png'), // Imagem do banner
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Imagem principal sobreposta no centro
                Positioned(
                  top: 120, // Ajusta a posição vertical da imagem
                  left: 20,
                  child: CircleAvatar(
                    radius: 60, // Tamanho da imagem
                    backgroundColor: Colors.black, //color
                    child: Padding(
                      padding: const EdgeInsets.all(1), // Border radius
                      child: ClipOval(child: Image.asset('assets/beagle.png')),
                    ),
                  ),
                ),

                Positioned(
                    bottom: 0,
                    right: 40,
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _openDoacaoPopup(context);
                          },
                          icon: Icon(Icons.wallet_giftcard),
                          label: Text('Doar'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            print("Seguir!");
                          },
                          icon: Icon(Icons.favorite),
                          label: Text('Seguir'),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'ONG 1',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ))
              ],
            ),

            SizedBox(height: 20), // Espaçamento para ajustar abaixo do banner

            // Informações da ONG
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey, // Cor de fundo do container
                  borderRadius:
                      BorderRadius.circular(15), // Bordas arredondadas
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            //Carousel
            FlutterCarousel(
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
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

            SizedBox(height: 20),

            //Mapa
            Column(
              children: [
                Text(
                  "Nossa Localização",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 450,
                    width: 450,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/mapa.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            //Publicações
            Column(
              children: [
                Text(
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
          ],
        ),
      ),
    );
  }
}

Widget buildCard(String imagePath, String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
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
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
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
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Doação',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
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
              SizedBox(height: 20.0),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                ),
                child: Text(
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
