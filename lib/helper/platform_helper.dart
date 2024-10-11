import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper
{
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  Database? _db;


  Future get database  async => _db ?? await initDatabase();

   // Future get database()
   // async {
   //   if(_db!=null)
   //     {
   //       return await initDatabase();
   //     }
   //   else
   //     {
   //       return  await _db;
   //     }
   // }

  Future<Database?> initDatabase()
  async {
    final path = await getDatabasesPath();
    final dbPath = join(path,"Contact.db");

    openDatabase(dbPath,version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE Contact(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        chat TEXT,
        phone TEXT NOT NULL);
        ''';
        await db.execute(sql);
      },

    );
    return _db;
  }

  Future insertData(String name, String chat, String phone) async {
    Database? db = await  database;
    String sql = '''INSERT INTO finance (name, chat, phone)
    VALUES (?,?,?);''';
    List<dynamic> args = [name, chat, phone];
    await db!.rawInsert(sql, args);
  }


}