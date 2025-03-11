import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui_store/localdb/query/categoryLocalQuery.dart';
import 'package:ui_store/localdb/query/productLocalQuery.dart';
import 'package:ui_store/models/categoryModel.dart';

class Dbhelper {
  List<String> dataQuery = [
    'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.title} ${ProductQuery.textType}, ${ProductQuery.description} ${ProductQuery.textType}, ${ProductQuery.category} ${ProductQuery.textType}, ${ProductQuery.price} ${ProductQuery.doubleType})',
    'CREATE TABLE ${CategoryQuery.tableName}(${CategoryQuery.slug} ${ProductQuery.textType}, ${CategoryQuery.name} ${ProductQuery.textType}, ${CategoryQuery.url} ${ProductQuery.textType})',
  ];
  Future<Database> openmyDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ui_store.db'),
      version: 1,
      onCreate: (db, version) {
        // return db.execute(
        //   'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.title} ${ProductQuery.textType}, ${ProductQuery.description} ${ProductQuery.textType}, ${ProductQuery.category} ${ProductQuery.textType}, ${ProductQuery.price} ${ProductQuery.doubleType})',
        // );
        // return db.execute(
        //   'CREATE TABLE ${CategoryQuery.tableName}(${CategoryQuery.slug} ${ProductQuery.textType}, ${CategoryQuery.name} ${ProductQuery.textType}, ${CategoryQuery.url} ${ProductQuery.textType})',
        // );
        // return dataQuery.forEach((element) {
        //   print(element);
        //   db.execute(element);
        // },);
        // for (int i = 0; i < dataQuery.length;) {
        //   return db.execute(dataQuery[i]);
        // }
        dataQuery.forEach((query) async {
          await db
              .execute(query)
              .then((value) {
                print('Berhasil');
              })
              .catchError((err) {
                print("Eror : ${err.toString()}");
              });
        });
      },
    );
  }

  Future<void> insertCategory({
    required String titleData,
    required Map<String, dynamic> data,
  }) async {
    final db = await openmyDatabase();
    // print(data);
    db.insert(titleData, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProduct({
    required String titleData,
    required Map<String, dynamic> data,
  }) async {
    final db = await openmyDatabase();
    db.insert(titleData, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCategory() async {
    final db = await openmyDatabase();
    return db.rawQuery("SELECT * FROM ${CategoryQuery.tableName}");
  }

  Future<List<Map<String, dynamic>>> getTaskByCategory(
    String categoryName,
  ) async {
    final db = await openmyDatabase();
    // return db.query(TableName);
    return db.rawQuery(
      "SELECT * FROM ${ProductQuery.tableName} WHERE ${ProductQuery.category} LIKE '%$categoryName%'",
    );
  }
}

// 'CREATE TABLE ${ProductQuery.tableName}(${ProductQuery.id} ${ProductQuery.idType}, ${ProductQuery.title} ${ProductQuery.textType})',
