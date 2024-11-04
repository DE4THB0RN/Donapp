import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputField extends StatefulWidget {
  final Function(String) onImageSelected; // Callback para passar a string base64 para o widget pai

  ImageInputField({required this.onImageSelected});

  @override
  _ImageInputFieldState createState() => _ImageInputFieldState();
}

class _ImageInputFieldState extends State<ImageInputField> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Converte a imagem em base64
      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);

      // Envia a string base64 para o widget pai
      widget.onImageSelected(base64String);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 40,
            backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
            child: _selectedImage == null
                ? Icon(Icons.add_a_photo, color: Colors.white)
                : null,
          ),
        ),
        if (_selectedImage != null)
          Text(
            'Imagem selecionada',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
      ],
    );
  }
}
