import 'package:sqflite/sqflite.dart' as sql;

class SQLUser {
  static Future<void> criaUsuario(sql.Database database) async {
    await database.execute("""CREATE TABLE usuario(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 nome TEXT,
 dataNasc DATE,
 email TEXT,
 senha TEXT
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'usuario.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaUsuario(database);
      },
    );
  }

  static Future<int> adicionarUsuario(
      String nome, String dataNasc, String email, String senha) async {
    final db = await SQLUser.db();
    final dados = {
      'nome': nome,
      'dataNasc': dataNasc,
      'email': email,
      'senha': senha
    };
    final id = await db.insert('usuario', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaUsuario() async {
    final db = await SQLUser.db();
    return db.query('usuario', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaUmUsuario(int id) async {
    final db = await SQLUser.db();
    return db.query('usuario', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizaUsuario(
      int id, String nome, String dataNasc, String email, String senha) async {
    final db = await SQLUser.db();
    final dados = {
      'nome': nome,
      'dataNasc': dataNasc,
      'email': email,
      'senha': senha
    };
    final result =
        await db.update('usuario', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> apagaUsuario(int id) async {
    final db = await SQLUser.db();
    try {
      await db.delete("usuario", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }
}
