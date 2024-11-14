import 'dart:convert';

import 'package:http/http.dart' as http;

class CepService {
  static Future<String> recuperaCep(String cep) async {
    Uri url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    http.Response response;
    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String estado = retorno["estado"];

    return (logradouro +
        "/" +
        complemento +
        "/" +
        bairro +
        "/" +
        localidade +
        "/" +
        estado);
  }
}
