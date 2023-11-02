// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _db; // Singleton databaseHelper

  //column and table
  final String favoriteTable = 'favorite';
  final String id = 'id';
  final String pid = 'pid';
  final String title = 'title';
  final String type = 'type';
  final String img = 'img';
  final String date = 'date';
  final String city = 'city';
  final String result = 'result';
  final String description = 'description';

  //1-check if _db exist , if not create it using initDB fun
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await intDB();
    // ignore: recursive_getters
    return db;
  }

  //2- create db fun (create file to store data (db))
  intDB() async {
    //determin path to create directory and put db inside it.
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, 'zoom.db');
    //open database from path
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    //version: 1 => mean (if replace app and version still 1 , the old db will removed)
    //                    but if version updated to 2 will update db.
    //_onCreate
    return myOwnDb;
  }

  //3- create db - row - column
  void _onCreate(Database db, int newVersion) async {
    //$artitle TEXT, $price DOUBLE(8,2), $originalPrice DOUBLE(0.2), $pic TEXT,
    //$artitle TEXT, $price DOUBLE(8,2), $originalPrice DOUBLE(0.2), $pic TEXT
    var sql2 =
        "CREATE TABLE $favoriteTable ($id INTEGER PRIMARY KEY autoincrement,$pid INTEGER, $title STRING, $type STRING, $img STRING,$date STRING, $city STRING, $result STRING, $description TEXT)";

    await db.execute(sql2);
  }

  Future<String> saveFavorite(
    int id,
    String title,
    String description,
    String type,
    String? img,
    String? date,
    String? city,
    String? result,
    String? inDate,
  ) async {
    var dbClient = await db;
    var sql =
        "INSERT INTO $favoriteTable ($pid, $title, $description, $img) VALUES ('$id','$title','$description','$img')";
    await dbClient!.rawQuery(sql);
    return 'done';
  }

  // Future getFavoriteCount() async {
  //   var dbClient = await db;
  //   int? count = Sqflite.firstIntValue(
  //       await dbClient!.rawQuery('SELECT COUNT(*) FROM $favoriteTable'));
  //   return count;
  // }

  // Future<List> getFavoriteList() async {
  //   var dbClient = await db;
  //   var sql = "SELECT pid FROM $favoriteTable ORDER BY id DESC";
  //   var result = await dbClient!.rawQuery(sql);
  //   return result.toList();
  // }

  deleteFavorite(int id) async {
    var dbClient = await db;
    var del = "Delete FROM $favoriteTable WHERE pid = $id";
    await dbClient!.rawQuery(del);
  }

  // deleteAllFavorite() async {
  //   var dbClient = await db;
  //   var del = "Delete FROM $favoriteTable";
  //   await dbClient!.rawQuery(del);
  // }

  //4-create user note model

  //5--Crud operation

  // Future<String> saveCart(FavoriteModel cart) async {
  //   var dbClient = await db;
  //   int? count = Sqflite.firstIntValue(await dbClient!
  //       .rawQuery('SELECT COUNT(*) FROM $userTable WHERE pid = ${cart.pid}'));
  //   if (count! > 0) {
  //     var up = "UPDATE $userTable SET qty = qty + 1 WHERE pid=${cart.pid}";
  //     await dbClient.rawQuery(up);
  //     return 'done';
  //   } else {
  //     var sql = "INSERT INTO $userTable (pid , qty) VALUES (${cart.pid} , '1')";
  //     await dbClient.rawQuery(sql);
  //     return 'done';
  //   }
  // }

  // Future<List<FavoriteModel>> getCartList() async {
  //   List<FavoriteModel> cartLst = [];
  //   var dbClient = await db;
  //   var sql = "SELECT * FROM $userTable ORDER BY id DESC";
  //   var result = await dbClient!.rawQuery(sql);
  //   for (var n in result) {
  //     cartLst.add(FavoriteModel.fromMap(n));
  //   }
  //   return cartLst;
  // }

  // Future<List> getCartListToSend() async {
  //   var dbClient = await db;
  //   var sql = "SELECT pid,qty FROM $userTable ORDER BY id DESC";
  //   var result = await dbClient!.rawQuery(sql);
  //   return result.toList();
  // }

  // Future<int?> geCount() async {
  //   var dbClient = await db;
  //   var sql = "SELECT COUNT(*) FROM $userTable";
  //   return Sqflite.firstIntValue(await dbClient!.rawQuery(sql));
  // }

  // deleteCart(int id) async {
  //   var dbClient = await db;
  //   var del = "Delete FROM $userTable WHERE pid = $id";
  //   await dbClient!.rawQuery(del);
  // }

  // deleteAllCart() async {
  //   var dbClient = await db;
  //   var del = "Delete FROM $userTable";
  //   await dbClient!.rawQuery(del);
  // }

  // Future<bool> updateCart(int id, int status) async {
  //   var dbClient = await db;
  //   if (status == 1) {
  //     var up = "UPDATE $userTable SET qty = qty + 1 WHERE pid=$id";
  //     await dbClient!.rawQuery(up);
  //   } else if (status == 2) {
  //     var sql = "SELECT qty FROM $userTable WHERE pid=$id";
  //     var result1 = await dbClient!.rawQuery(sql);
  //     if (Sqflite.firstIntValue(result1)! > 1) {
  //       var up = "UPDATE $userTable SET qty = qty - 1 WHERE pid=$id";
  //       await dbClient.rawQuery(up);
  //     } else {
  //       var del = "Delete FROM $userTable WHERE pid = $id";
  //       await dbClient.rawQuery(del);
  //     }
  //   }
  //   return true;
  // }

  // Future close() async {
  //   var dbClient = await db;
  //   return await dbClient!.close();
  // }
}
