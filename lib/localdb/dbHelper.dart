import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui_store/localdb/query/productLocalQuery.dart';

class Dbhelper {
  Future<Database> openmyDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ui_store.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.title} ${ProductQuery.textType})',
        );
      },
    );
  }

  Future<void> insertProduct({
    required String titleData,
    required Map<String, dynamic> data,
  }) async {
    final db = await openmyDatabase();
    // print(data);
    db.insert(titleData, {
      'id': data['id'],
      'title': data['title'],
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getTask(String TableName) async {
    final db = await openmyDatabase();
    return db.query(TableName);
  }
}
