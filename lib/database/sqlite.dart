import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tayar/database/models/favourites.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "local.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Favourites(`id` INTEGER PRIMARY KEY, `documentID` TEXT, `title` TEXT, `image` TEXT);");
    print("Created `Favourites` table");
  }

  void saveFavourite(Favourite favourite) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO Favourites(`documentID`,`title`,`image`) VALUES ('${favourite.documentID}','${favourite.title}','${favourite.image}');");
    });
  }

  Future<List<Favourite>> getFavourites() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Favourites');
    List<Favourite> favourites = new List();
    for (int i = 0; i < list.length; i++) {
      favourites.add(new Favourite(
          list[i]["documentID"], list[i]["title"], list[i]["image"]));
    }
    print("List length: ${favourites.length}.");
    return favourites;
  }
}
