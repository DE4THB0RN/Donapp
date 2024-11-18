import 'package:flutter/material.dart';
import 'package:donapp/Theme/Color.dart';

class LocalCard extends StatelessWidget {
  final String rua;
  final String bairro;
  final String complemento;
  final int numero;

  const LocalCard({
    required this.rua,
    required this.bairro,
    required this.numero,
    required this.complemento,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rua: $rua',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.appBarColor,
            ),
          ),
          Text(
            'Bairro: $bairro',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.appBarColor,
            ),
          ),
          if (numero != 0)
            Text(
              'Número: $numero',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.appBarColor,
              ),
            ),
          if (complemento.isNotEmpty)
            Text(
              'Complemento: $complemento',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.appBarColor,
              ),
            ),
        ],
      ),
    );
  }
}
