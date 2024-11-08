import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //creating a singleton class
  static final DBHelper _instance = DBHelper._();
  DBHelper._();
  static DBHelper get getInstance => _instance;

  //table note
  static const String TABLE_NOTE = "note";
  static const String COLUMN_NOTE_SNO = "sno";
  static const String COLUMN_NOTE_TITLE = "title";
  static const String COLUMN_NOTE_DESC = "desc";
  static const String COLUMN_NOTE_IMAGE = "img";

  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, 'noteDB.db');

    // Correcting the SQL syntax error: 'auto increment' -> 'AUTOINCREMENT'
    return await openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $TABLE_NOTE ($COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTE_TITLE TEXT, $COLUMN_NOTE_DESC TEXT ,$COLUMN_NOTE_IMAGE TEXT)");
    }, version: 1);
  }

  //all queries
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();
    int rowsAffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mTitle,
      COLUMN_NOTE_DESC: mDesc,
    });
    return rowsAffected > 0;
  }

  //fetching all the notes after insertion/updation/deletion
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }

  //updating the data
  Future<bool> updateNotes(
      {required String mTitle, required String mDesc, required int sno}) async {
    var db = await getDB();
    int rowsAffected = await db.update(
      TABLE_NOTE,
      {
        COLUMN_NOTE_TITLE: mTitle,
        COLUMN_NOTE_DESC: mDesc,
      },
      //updating only that notes whose COLUMN_NOTE_SNO is sno
      where: "${COLUMN_NOTE_SNO}= $sno",
    );

    return rowsAffected > 0;
  }
  // deleting the notes

  ////
  Future<int> removeNotes(int id) async {
    var db = await getDB();
    return await db
        .delete(TABLE_NOTE, where: '$COLUMN_NOTE_SNO = ?', whereArgs: [id]);
  }
}
