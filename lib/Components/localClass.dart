class Localclass {
  String cep = '';
  String rua = '';
  String complemento = '';
  String bairro = '';
  String cidade = '';
  String estado = '';
  int numero = 0;

  Localclass(String cep, String rua, String complemento, int numero,
      String bairro, String cidade, String estado) {
    this.cep = cep;
    this.rua = rua;
    this.complemento = complemento;
    this.numero = numero;
    this.bairro = bairro;
    this.cidade = cidade;
    this.estado = estado;
  }

  Localclass LocalclassWC(
      String cep, String rua, String bairro, String cidade, String estado) {
    return Localclass(cep, rua, complemento, numero, bairro, cidade, estado);
  }
}
