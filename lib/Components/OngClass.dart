class Ongclass {
  int id = 0;
  String nome = '';
  String desc = '';
  String banner = '';
  String perfil = '';

  Ongclass(String nome, String desc, String banner, String perfil, int id) {
    this.nome = nome;
    this.desc = desc;
    this.banner = banner;
    this.perfil = perfil;
    this.id = id;
  }

  static Ongclass ongClassNull() {
    return Ongclass('', '', '', '', 0);
  }
}
