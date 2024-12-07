import 'package:sqflite/sqflite.dart' as sql;

class SQLDonate {
  static Future<void> criaDonate(sql.Database database) async {
    await database.execute("""CREATE TABLE donate(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 id_ong INTEGER, 
 id_user INTEGER,
 valor REAL,
 dataDonate DATE,
 FOREIGN KEY(id_ong) REFERENCES ONG(id),
 FOREIGN KEY(id_user) REFERENCES usuario(id)
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'donate.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaDonate(database);
      },
    );
  }

  static Future<int> adicionarDonate(
      int idOng, int idUser, double valor, String dataDonate) async {
    final db = await SQLDonate.db();
    final dados = {
      'id_ong': idOng,
      'id_user': idUser,
      'valor': valor,
      'dataDonate': dataDonate
    };
    final id = await db.insert('donate', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaDonates() async {
    final db = await SQLDonate.db();
    return db.query('donate', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaDonatesOng(int idOng) async {
    final db = await SQLDonate.db();
    return db.query('donate', where: "id_ong = ?", whereArgs: [idOng]);
  }

  static Future<List<Map<String, dynamic>>> pegaDonatesUser(int idUser) async {
    final db = await SQLDonate.db();
    return db.query('donate', where: "id_user = ?", whereArgs: [idUser]);
  }

  static Future<void> apagaDonate(int id) async {
    final db = await SQLDonate.db();
    try {
      await db.delete("donate", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }

  static Future<void> dropDataBaseDonate() async {
    try {
      await sql.deleteDatabase('donate.db');
    } catch (err) {
      print("varios erro donate");
    }
  }
}
