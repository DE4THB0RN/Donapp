import 'package:sqflite/sqflite.dart' as sql;

String cep = '';
String rua = '';
String complemento = '';
int numero = 0;
String bairro = '';
String cidade = '';
String estado = '';

class SQLLocal {
  static Future<void> criaOngLocal(sql.Database database) async {
    await database.execute("""CREATE TABLE local_ONG(
 id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
 cep TEXT,
 rua TEXT,
 complemento TEXT,
 numero INTEGER,
 bairro TEXT,
 cidade TEXT,
 estado TEXT,
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
        await criaOngLocal(database);
      },
    );
  }

  static Future<int> adicionarLocal(
      String cep,
      String rua,
      String complemento,
      int numero,
      String bairro,
      String cidade,
      String estado,
      int idOng) async {
    final db = await SQLLocal.db();
    final dados = {
      'cep': cep,
      'rua': rua,
      'complemento': complemento,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'id_ong': idOng
    };
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
    int idOng,
    int id,
    String cep,
    String rua,
    String complemento,
    int numero,
    String bairro,
    String cidade,
    String estado,
  ) async {
    final db = await SQLLocal.db();
    final dados = {
      'cep': cep,
      'rua': rua,
      'complemento': complemento,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'id_ong': idOng
    };
    final result =
        await db.update('local_ONG', dados, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> apagaLocal(int id) async {
    final db = await SQLLocal.db();
    try {
      await db.delete("local_ONG", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Erro ao apagar o item item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> pegaUmLocalId(int id) async {
    final db = await SQLLocal.db();
    return db.query('local_ONG', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> dropDataBaseLocal() async {
    try {
      await sql.deleteDatabase('local_ONG.db');
    } catch (err) {
      print("varios erro");
    }
  }
}
