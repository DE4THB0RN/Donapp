class UserHelper {
  static String _nome = '';
  static String _email = '';

  static String GetNome() {
    return _nome;
  }

  static String GetEmail() {
    return _email;
  }

  static void SetNome(String nome) {
    UserHelper._nome = nome;
  }

  static void SetEmail(String email) {
    UserHelper._email = email;
  }
}
