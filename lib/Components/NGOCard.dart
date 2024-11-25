import 'dart:convert';

import 'package:flutter/material.dart';

class NGOCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int id;

  const NGOCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.id,
  }) : super(key: key);

  @override
  State<NGOCard> createState() => _NGOCardState();
}

class _NGOCardState extends State<NGOCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(
        context,
        'ONG',
        arguments: widget.id,
      ),
      child: SizedBox(
        width: double.infinity, // largura da tela
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // espaçamento interno
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8.0), // Bordas arredondadas na imagem
                  child: Image.memory(
                    base64Decode(widget.image),
                    width: 130,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10), // espaço entre imagem e texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20, // ajuste do tamanho do texto
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
