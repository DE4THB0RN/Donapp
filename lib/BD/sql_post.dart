import 'package:sqflite/sqflite.dart' as sql;

String titulo = '';
String coment = '';
String imagem = '';
int idOng = 0;

class SqlPost {
  static Future<void> criaPostOng(sql.Database database) async {
    await database.execute("""CREATE TABLE post_ONG(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 titulo TEXT,
 descricao TEXT,
 imagem TEXT,
 id_ong INTEGER, 
 FOREIGN KEY(id_ong) REFERENCES ONG(id) 
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'post_ONG.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaPostOng(database);
      },
    );
  }

  static Future<int> adicionarPost(
      String titulo, String descricao, String imagem, int idOng) async {
    final db = await SqlPost.db();
    final dados = {
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'id_ong': idOng
    };
    final id = await db.insert('post_ONG', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaPost() async {
    final db = await SqlPost.db();
    return db.query('post_ONG', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaPostsOng(int idOng) async {
    final db = await SqlPost.db();
    return db.query('post_ONG', where: "id_ong = ?", whereArgs: [idOng]);
  }

  // talvez de merda
  static Future<int> atualizaPost(
      int id, String titulo, String descricao, String imagem, int idOng) async {
    final db = await SqlPost.db();
    final dados = {
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'id_ong': idOng
    };
    final result =
        await db.update('post_ONG', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> apagaPost(int id) async {
    final db = await SqlPost.db();
    try {
      await db.delete("post_ONG", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }

  static Future<void> dropDataBaseLocal() async {
    try {
      await sql.deleteDatabase('post_ONG.db');
    } catch (err) {
      print("varios erro");
    }
  }
}
