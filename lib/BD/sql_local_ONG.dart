import 'package:sqflite/sqflite.dart' as sql;

class SQLLocal {
  static Future<void> criaOng(sql.Database database) async {
    await database.execute("""CREATE TABLE local_ONG(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 coordenada TEXT,
 id_ong INTEGER, 
 FOREIGN KEY(id_ong) REFERENCES ONG(id) 
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

  static Future<int> adicionarLocal(String coordenada, int idOng) async {
    final db = await SQLLocal.db();
    final dados = {'coordenada': coordenada, 'id_ong': idOng};
    final id = await db.insert('local_ONG', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> pegaLocal() async {
    final db = await SQLLocal.db();
    return db.query('local_ONG', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> pegaLocaisOng(int idOng) async {
    final db = await SQLLocal.db();
    return db.query('local_ONG', where: "id_ong = ?", whereArgs: [idOng]);
  }

  // talvez de merda
  static Future<int> atualizaLocal(
      int idOng, String localAntigo, String localNovo) async {
    final db = await SQLLocal.db();
    final dados = {'coordenada': localNovo, 'id_ong': idOng};
    final result = await db.update('local_ONG', dados,
        where: "id_ong = ? , coordenada = ?", whereArgs: [idOng, localAntigo]);
    return result;
  }

  static Future<void> apagaLocal(int idOng, String local) async {
    final db = await SQLLocal.db();
    try {
      await db.delete("local_ONG",
          where: "id_ong = ? , coordenada = ?", whereArgs: [idOng, local]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }
}
