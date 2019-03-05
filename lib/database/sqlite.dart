import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tayar/database/models/favouritesModel.dart';

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
  }

  Future<bool> check(String documentID) async {
    var dbClient = await db;
    var result = Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(`id`) FROM Favourites WHERE `documentID` = '$documentID';"));
    if (result == 1) {
      return true;
    }
    return false;
  }

  Future<bool> toggleFavourite(Favourite favourite) async {
    return check(favourite.documentID).then((result) {
      if (result) {
        _removeFavourite(favourite);
        return false;
      } else {
        _addFavourite(favourite);
        return true;
      }
    });
  }

  void _addFavourite(Favourite favourite) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO Favourites(`documentID`,`title`,`image`) VALUES ('${favourite.documentID}', '${favourite.title}','${favourite.image}');");
    });
  }

  void _removeFavourite(Favourite favourite) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete(
          "DELETE FROM Favourites WHERE documentID = '${favourite.documentID}';");
    });
  }

  Future<List<Favourite>> getFavourites() async {
    var dbClient = await db;
    List<Map> favList = await dbClient.rawQuery('SELECT * FROM Favourites;');
    List<Favourite> favourites = new List();
    for (int i = 0; i < favList.length; i++) {
      favourites.add(new Favourite(
          favList[i]["documentID"], favList[i]["title"], favList[i]["image"]));
    }
    return favourites;
  }
}
