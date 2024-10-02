import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

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
                            //o que acontece quando pressionado
                          },
                          icon: Icon(Icons.favorite),
                          label: Text('Seguir'),
                        ),
                        SizedBox(width: 20),
                        Text('ONG 1',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
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
                  color: Colors.amber, // Cor de fundo do container
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

            FlutterCarousel(
              options: FlutterCarouselOptions(
                height: 400.0,
                showIndicator: true,
                slideIndicator: CircularSlideIndicator(),
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Text(
                          'text $i',
                          style: TextStyle(fontSize: 16.0),
                        ));
                  },
                );
              }).toList(),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         // Primeira imagem
            //         Container(
            //           width: 150,
            //           height: 150,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             image: DecorationImage(
            //               image: AssetImage('assets/dog1.png'),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),

            //         SizedBox(width: 10),

            //         // Segunda imagem
            //         Container(
            //           width: 150,
            //           height: 150,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             image: DecorationImage(
            //               image: AssetImage('assets/dog2.png'),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),

            //         SizedBox(width: 10),

            //         // Terceira imagem
            //         Container(
            //           width: 150,
            //           height: 150,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             image: DecorationImage(
            //               image: AssetImage('assets/dog3.png'),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),

            //         SizedBox(width: 10),

            //         Container(
            //           width: 150,
            //           height: 150,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             image: DecorationImage(
            //               image: AssetImage('assets/dog3.png'),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            SizedBox(height: 20),

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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/dog1.png"),
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
                                "Coisas que acontecem",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Inaugurada em 2003, a Cão Viver é uma das ONGs mais conhecidas para a adoção de cães e gatos em BH. ",
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber, // Cor de fundo do container
                      borderRadius:
                          BorderRadius.circular(15), // Bordas arredondadas
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/dog1.png"),
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
                                "Coisas que acontecem",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "diminui o texto pra ver oq rola ",
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber, // Cor de fundo do container
                      borderRadius:
                          BorderRadius.circular(15), // Bordas arredondadas
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
