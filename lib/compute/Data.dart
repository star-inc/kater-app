import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KaterData {
  Database database;

  void connect() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE account(id INTEGER PRIMARY KEY, password TEXT, remember INTEGER, keep_alive INTEGER)",
        );
      },
      version: 1,
    );
  }
}