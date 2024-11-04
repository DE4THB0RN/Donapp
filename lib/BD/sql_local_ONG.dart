import 'package:sqflite/sqflite.dart' as sql;

class SQLONG {
  static Future<void> criaOng(sql.Database database) async {
    await database.execute("""CREATE TABLE local_ONG(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 coordenada TEXT,
 id_ong INTEGER FOREIGN KEY REFERENCES ONG(id) 
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'local_ONG.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaOng(database);
      },
    );
  }

  static Future<int> adicionarUsuario(
      String nome, String dataNasc, String email, String senha) async {
    final db = await SQLONG.db();
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
    final db = await SQLONG.db();
    return db.query('usuario', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaUmUsuario(int id) async {
    final db = await SQLONG.db();
    return db.query('usuario', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizaUsuario(
      int id, String nome, String dataNasc, String email, String senha) async {
    final db = await SQLONG.db();
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
    final db = await SQLONG.db();
    try {
      await db.delete("usuario", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> pegaUmUsuarioEmail(
      String email, String senha) async {
    final db = await SQLONG.db();
    return db.query('usuario',
        where: "email = ? AND senha = ?", whereArgs: [email, senha], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> pegaUmUsuarioEmail2(
      String email) async {
    final db = await SQLONG.db();
    return db.query('usuario',
        where: "email = ?", whereArgs: [email], limit: 1);
  }
}
