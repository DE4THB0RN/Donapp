class Localclass {
  String cep = '';
  String rua = '';
  String complemento = '';
  String bairro = '';
  String cidade = '';
  String estado = '';

  Localclass(String cep, String rua, String complemento, String bairro,
      String cidade, String estado) {
    this.cep = cep;
    this.rua = rua;
    this.complemento = complemento;
    this.bairro = bairro;
    this.cidade = cidade;
    this.estado = estado;
  }

  Localclass LocalclassWC(
      String cep, String rua, String bairro, String cidade, String estado) {
    return Localclass(cep, rua, complemento, bairro, cidade, estado);
  }
}
