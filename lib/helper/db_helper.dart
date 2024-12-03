import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper
{
  DatabaseHelper._();

  static DatabaseHelper databaseHelper=DatabaseHelper._();

  Database? _database;

  Future<Database?> get database async => _database??await initDatabase();

  Future<Database> initDatabase()
  async {
    var path = await getDatabasesPath();
    String Dbpath = join(path, 'attendance.db');

    return _database = await openDatabase(Dbpath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              '''CREATE TABLE attendance (id INTEGER PRIMARY KEY, name TEXT, date TEXT, present TEXT)''');
        });
  }

  Future<void> addData(String name,String date,String present)
  async {
    final db=await database;
    String sql='''
    INSERT INTO attendance(name, date, present) VALUES(?, ?, ?);
    ''';
    List args=[name,date,present];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map<String, Object?>>> readData()
  async {
    final db=await database;
    String sql='''
    SELECT * FROM attendance;
    ''';
    return await db!.rawQuery(sql);
  }

  Future<void> updateData(String name,String date,String present,int id)
  async {
    final db=await database;
    String sql='''
    UPDATE attendance SET name = ?, date = ?, present = ? WHERE id = ?;
    ''';
    List args=[name,date,present,id];
    await db!.rawUpdate(sql,args);
  }

  Future<void> deleteData(int id)
  async {
    final db=await database;
    String sql='''
    DELETE FROM attendance WHERE id = ?;
    ''';
    List args=[id];
    await db!.rawDelete(sql,args);
  }

  Future<List<Map<String, Object?>>> getDateData(String date)
  async {
    final db=await database;
    String sql='''
    SELECT * FROM attendance WHERE date = ?;
    ''';
    List args=[date];
    return await db!.rawQuery(sql,args);
  }
}

//Student Name, Date, Present (Yes/No).