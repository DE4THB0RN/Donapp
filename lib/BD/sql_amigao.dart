
import 'package:donapp/BD/sql_user.dart';

class SQL_Amigao{
  static void db_helper() async {
    SQLUser.db();
  }

  static void novoUsuario(
      String nome, String dataNasc, String email, int senha) async {
    SQLUser.adicionarUsuario(nome,dataNasc, email,senha);
  }

  static void pegaUsuarios(int id) async {
    SQLUser.pegaUmUsuario(id);
  }

}