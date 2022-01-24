// ignore_for_file: avoid_print


import 'package:flutter/cupertino.dart';
import 'package:flutter_caching_using_localdb/Model/UserPost.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends ChangeNotifier {
  Database? _db;

  Future<Database?> get database async{
    var databasesPath = await getDatabasesPath();
    _db ??=await openDatabase(join(databasesPath,'Posts.db'),version: 1 ,onCreate: (db, version) => db.execute(UserPost.createTable),);
    return _db;
  }

  DbHelper.internal();

  static DbHelper? instance;
  factory DbHelper(){
    instance ??= DbHelper.internal();
    return instance!;
  }

  Future<bool> insertPost(UserPost s) async {
    Database? db =await database;
    int rowId =await db!.insert(UserPost.tableName, s.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
    return rowId>0;
  }

  Future<bool> updatePost(UserPost s) async {
    Database? db =await database;
    int rowId = await db!.update(UserPost.tableName, s.toMap(), where:'${UserPost.userIdKey} = ? ', whereArgs: [s.userId] );
    notifyListeners();
    return rowId>0;
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async{
    var db = await database;
    var listOfMaps = await db!.query(UserPost.tableName);
    //notifyListeners();
    return listOfMaps;
  }

  // Future<bool> insertPosts(List<UserPost> posts) async {
  //   Database? db =await database;
  //   int rowId =await db!.insert(UserPost.tableName, s.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  //   notifyListeners();
  //   return rowId>0;
  // }
}