import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String> genericProfile() async {
  try {
    // Carregar os bytes da imagem do arquivo na pasta assets
    ByteData originalBytes = await rootBundle.load("assets/GenericProfile.png");
    Uint8List imageBytes = originalBytes.buffer.asUint8List();

    // Comprimir a imagem usando flutter_image_compress
    Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      quality: 50, // Ajuste a qualidade conforme necessário
    );

    // Converter os bytes comprimidos para Base64 e retornar
    return base64Encode(compressedBytes);
  } catch (e) {
    return 'Erro ao pegar a imagem';
  }
}

Future<String> genericBanner() async {
  try {
    // Carregar os bytes da imagem do arquivo na pasta assets
    ByteData originalBytes = await rootBundle.load("assets/GenericBanner.png");
    Uint8List imageBytes = originalBytes.buffer.asUint8List();

    // Comprimir a imagem usando flutter_image_compress
    Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      quality: 70, // Ajuste a qualidade conforme necessário
    );

    // Converter os bytes comprimidos para Base64 e retornar
    return base64Encode(compressedBytes);
  } catch (e) {
    return 'Erro ao pegar a imagem';
  }
}
