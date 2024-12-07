import 'package:sqflite/sqflite.dart' as sql;

class SQLFollow {
  static Future<void> criaFollow(sql.Database database) async {
    await database.execute("""CREATE TABLE follow(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 id_ong INTEGER, 
 id_user INTEGER,
 FOREIGN KEY(id_ong) REFERENCES ONG(id),
 FOREIGN KEY(id_user) REFERENCES usuario(id)
 )
 """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'follow.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaFollow(database);
      },
    );
  }

  static Future<int> adicionarFollow(int idUser, int idOng) async {
    final db = await SQLFollow.db();
    final dados = {'id_ong': idOng, 'id_user': idUser};
    final id = await db.insert('follow', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegafollows() async {
    final db = await SQLFollow.db();
    return db.query('follow', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegafollowsUser(int idUser) async {
    final db = await SQLFollow.db();
    return db.query('follow', where: "id_user = ?", whereArgs: [idUser]);
  }

  static Future<List<Map<String, dynamic>>> pegafollowsUserOng(
      int idUser, int idOng) async {
    final db = await SQLFollow.db();
    return db.query('follow',
        where: "id_user = ? AND id_ong = ?",
        whereArgs: [idUser, idOng],
        limit: 1);
  }

  static Future<void> apagaFollow(int id) async {
    final db = await SQLFollow.db();
    try {
      await db.delete("follow", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item: $err");
    }
  }

  static Future<void> dropDataBaseDonate() async {
    try {
      await sql.deleteDatabase('follow.db');
    } catch (err) {
      print("varios erro follow");
    }
  }
}
