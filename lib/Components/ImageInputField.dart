import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageShape { square, circle }

class ImageInputField extends StatefulWidget {
  final ValueChanged<String> onImageSelected;
  final ImageShape shape;

  const ImageInputField({
    required this.onImageSelected,
    this.shape = ImageShape.square,
    Key? key,
  }) : super(key: key);

  @override
  _ImageInputFieldState createState() => _ImageInputFieldState();
}

class _ImageInputFieldState extends State<ImageInputField> {
  Uint8List? _imageData;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() {
        _imageData = bytes;
      });

      widget.onImageSelected(base64String);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: widget.shape == ImageShape.circle ? BoxShape.circle : BoxShape.rectangle,
          image: _imageData != null
              ? DecorationImage(
                  image: MemoryImage(_imageData!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _imageData == null
            ? Icon(
                Icons.add_a_photo,
                size: 30,
                color: Colors.grey[600],
              )
            : null,
      ),
    );
  }
}
