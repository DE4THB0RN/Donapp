import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar o valor monetário

class DoacaoCard extends StatefulWidget {
  final String dia;
  final double valor;

  const DoacaoCard({Key? key, required this.dia, required this.valor})
      : super(key: key);

  @override
  State<DoacaoCard> createState() => _DoacaoCardState();
}

class _DoacaoCardState extends State<DoacaoCard> {
  String _formatarValor(double valor) {
    // Formatando o valor como R$x.xxx,xx
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return formatter.format(valor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Doação dia ${widget.dia}',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0), // Espaçamento entre o texto e o valor
          Text(
            _formatarValor(widget.valor),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
