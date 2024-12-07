import 'package:sqflite/sqflite.dart' as sql;

class SQLONG {
  static Future<void> criaOng(sql.Database database) async {
    await database.execute("""CREATE TABLE ONG(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 nome TEXT UNIQUE,
 email TEXT UNIQUE,
 senha TEXT,
 cnpj TEXT UNIQUE,
 desc TEXT,
 foto_perfil TEXT,
 foto_banner TEXT
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'ONG.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaOng(database);
      },
    );
  }

  static Future<int> adicionarONG(
      String nome, String email, String senha, String cnpj) async {
    final db = await SQLONG.db();
    final dados = {
      'nome': nome,
      'cnpj': cnpj,
      'email': email,
      'senha': senha,
      'desc': '',
      'foto_perfil': '',
      'foto_banner': ''
    };
    final id = await db.insert('ONG', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaONG() async {
    final db = await SQLONG.db();
    return db.query('ONG', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaONGLimit() async {
    final db = await SQLONG.db();
    return db.query('ONG', orderBy: "id", limit: 20);
  }

  static Future<List<Map<String, dynamic>>> pegaUmaONG(int id) async {
    final db = await SQLONG.db();
    return db.query('ONG', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> atualizaONG(int id, String nome, String cnpj, String email,
      String senha, String desc, String fotoPerfil, String fotoBanner) async {
    final db = await SQLONG.db();
    final dados = {
      'nome': nome,
      'cnpj': cnpj,
      'email': email,
      'senha': senha,
      'desc': desc,
      'foto_perfil': fotoPerfil,
      'foto_banner': fotoBanner
    };
    final result =
        await db.update('ONG', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> apagaONG(int id) async {
    final db = await SQLONG.db();
    try {
      await db.delete("ONG", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> pegaUmaONGEmail(
      String email, String senha) async {
    final db = await SQLONG.db();
    return db.query('ONG',
        where: "email = ? AND senha = ?", whereArgs: [email, senha], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> pegaUmaONGEmail2(
      String email) async {
    final db = await SQLONG.db();
    return db.query('ONG', where: "email = ?", whereArgs: [email], limit: 1);
  }

  static Future<void> dropDataBaseONG() async {
    try {
      await sql.deleteDatabase('ONG.db');
    } catch (err) {
      print("varios erro");
    }
  }

  static Future<int> pegaIdOng(String email) async {
    final db = await SQLONG.db();
    final result =
        await db.query('ONG', where: "email = ?", whereArgs: [email]);
    int? id_result = result.first['id'] as int?;
    if (id_result == null) {
      return -1;
    }
    return id_result;
  }
}
