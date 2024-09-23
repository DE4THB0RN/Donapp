import 'package:flutter/material.dart';

class Loginmethods extends StatefulWidget {
  const Loginmethods({super.key});

  @override
  State<Loginmethods> createState() => _LoginmethodsState();
}

class _LoginmethodsState extends State<Loginmethods> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(labelText: 'Insira texto aqui'),
            style: TextStyle(fontSize: 20, color: Colors.white),
            maxLength: 20,
            enabled: true,
            keyboardType: TextInputType.text,
            controller: _controller,
            //onChanged: (value) => {print(value)},
          ),
        ),
        ElevatedButton(
          onPressed: () => {print(_controller.text)},
          child: Text('Enviar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(230, 192, 192, 192),
          ),
        )
      ],
    );
  }
}
