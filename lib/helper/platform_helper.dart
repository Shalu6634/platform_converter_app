
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper
{
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  Database? _db;

  Future<Database> get database async => _db ?? await initDatabase();


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
// create table
  Future<Database> initDatabase()
  async {
    final path = await getDatabasesPath();
    final dbPath = join(path,"Contact.db");

     _db = await openDatabase(dbPath,version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE Contact(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        chat TEXT NOT NULL,
        phone TEXT NOT NULL);
        ''';
        await db.execute(sql);
      },

    );
    return _db!;
  }

  //add data in table
  Future<void> insertData(String name, String chat, String phone)  async {
    Database? db = await database;
    String sql = '''INSERT INTO Contact (name,chat,phone)
    VALUES (?,?,?);''';
    List args = [name,chat,phone];
    await  db.rawInsert(sql,args);
  }


// show data in table
  Future<List<Map<String, Object?>>> readData() async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM Contact;
    ''';
    return await db.rawQuery(sql);
  }

  Future<void> removeInfo(int id)
  async {
    Database? db=await database;
    String sql='''
    DELETE  FROM Contact WHERE id = ?;
    ''';
    List args=[id];
    await db.rawDelete(sql,args);
  }

  Future<void> updateInfo(String name,String chat,String phone,int id)
  async {
    Database? db = await database;
    String sql = '''UPDATE Contact SET name = ?,chat = ?,phone = ? WHERE id = ?;
    ''';
    List args = [name,chat,phone,id];
    await db.rawUpdate(sql,args);
  }

}