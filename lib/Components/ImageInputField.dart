import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputField extends StatefulWidget {
  final Function(String) onImageSelected;

  const ImageInputField({required this.onImageSelected, Key? key}) : super(key: key);

  @override
  _ImageInputFieldState createState() => _ImageInputFieldState();
}

class _ImageInputFieldState extends State<ImageInputField> {
  String? _imageBase64; // Variável para armazenar a imagem em base64
  File? _imageFile; // Variável para armazenar o arquivo de imagem selecionado

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      final bytes = await _imageFile!.readAsBytes();
      _imageBase64 = base64Encode(bytes);

      setState(() {}); // Atualiza o estado para mostrar a imagem

      widget.onImageSelected(_imageBase64!); // Retorna a string base64
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 200, // Define a largura do quadrado
        height: 150, // Define a altura do quadrado para manter o formato
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
          image: _imageFile != null
              ? DecorationImage(
                  image: FileImage(_imageFile!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _imageFile == null
            ? Center(child: Icon(Icons.add_a_photo, color: Colors.grey[700]))
            : null, // Mostra o ícone se não houver imagem
      ),
    );
  }
}
