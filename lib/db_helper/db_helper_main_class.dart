import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tutor_finder/db_helper/division_data_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._instance();
  static Database _db;
  DBHelper._instance();

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'database.db';
    final appDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return appDB;
  }

  Future _createDB(Database db, int version) async {
    //User Details
    await db.execute(
        'CREATE TABLE division_details (DISTRICT VARCHAR , DIVISION VARCHAR,ID INTEGER PRIMARY KEY, THANA VARCHAR)');
  }

  Future<List<Map<String, dynamic>>> getDivisionMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.query('division_details');
    return result;
  }

  Future<List<DivisionModel>> getDivisionList() async {
    final List<Map<String, dynamic>> savedOrderList =
        await getDivisionMapList();
    final List<DivisionModel> devivsionList = [];
    savedOrderList.forEach((element) {
      devivsionList.add(DivisionModel.fromMap(element));
    });
    return devivsionList;
  }

  Future<int> insertDivisionOrder(DivisionModel divisionModel) async {
    Database db = await this.db;
    final int result =
        await db.insert('division_details', divisionModel.toMap());
    print('division inserted: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getDivisionAllList() async {
    Database db = await instance.db;
    // int count = Sqflite.firstIntValue(
    //     await db.rawQuery('SELECT * FROM $tableName'));

    //print('all products: $count');
    var result = await db.rawQuery('SELECT COUNT(*) FROM "division_details"');
    print('result: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getDivision() async {
    Database db = await instance.db;
    // int count = Sqflite.firstIntValue(
    //     await db.rawQuery('SELECT * FROM $tableName'));

    //print('all products: $count');
    var result =
        await db.rawQuery('SELECT DISTINCT(DIVISION) FROM "division_details"');
    print('result: $result');
    return result;
  }

  Future insertDivDisData(DivisionModel divisionModel, context) async {
    Database db = await this.db;

    await db.transaction((txn) async {
   //   int id1 = await txn.insert('division_details', divisionModel.toMap(),
      //    conflictAlgorithm: ConflictAlgorithm.ignore);
      txn.batch().commit();
      txn.batch().commit(continueOnError: true);
      // print('product insert: $id1');
    }).whenComplete(() {
      print('inserted');
    });
  }

  Future<List<Map<String, dynamic>>> dropTable() async {
    Database db = await instance.db;
    // int count = Sqflite.firstIntValue(
    //     await db.rawQuery('SELECT * FROM $tableName'));

    //print('all products: $count');
    var result = await db.rawQuery('DROP TABLE "division_details"');
    print('result: $result');
    return result;
  }

  Future tableIsEmpty() async {
    Database db = await this.db;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT * FROM "division_details"'));

    // print(count);
    return count;
  }

  Future<List<Map<String, dynamic>>> getDistrict(var division) async {
    Database db = await instance.db;
    var result = await db.rawQuery(
        'SELECT DISTINCT(DISTRICT)  FROM "division_details" WHERE DIVISION = "$division"');

    //print(': $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getThana(var district) async {
    Database db = await instance.db;
    var result = await db.rawQuery(
        'SELECT DISTINCT(THANA)  FROM "division_details" WHERE DISTRICT = "$district"');

    //print(': $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getupper() async {
    Database db = await instance.db;
    var result = await db.rawQuery(
        'Select CONCAT(UPPER(DISTRICT,1,1)),LOWER(DISTRICT,2)) from "division_details"');

    //print(': $result');
    return result;
  }
}
