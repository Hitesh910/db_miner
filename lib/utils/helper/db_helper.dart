import 'package:sqflite/sqflite.dart';

import '../../screen/favourite/model/db_model.dart';


class DbHelper {
 static DbHelper helper = DbHelper._();
  DbHelper._();
  Database? database;

  Future<Database> checkDB() async {
    print("=================== 1");
    if (database == null) {
      print(true);
      database = await initDB();
    }
    return database!;
  }

 Future<Database> initDB() async {
   String folder = await getDatabasesPath();
   String path = "$folder/demo.db";

   return await openDatabase(
     path,
     version: 1,
     onCreate: (db, version) {
       String query1 = "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
       // "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
       String query2 = "CREATE TABLE entry (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,category TEXT,amount TEXT,date INTERGER,time INTERGER,status INTERGER)";
       db.execute(query1);
       db.execute(query2);
     },
   );
   // database.execute(query);
 }

  Future<void> insertDB({quotes, author, image}) async {
    database = await checkDB();
    print(quotes);
    print("=================== 3");

    String query = "INSERT INTO quotes(quotes,author,image) VALUES('$quotes','$author','$image')";
    await database!.rawInsert(query);
  }

  Future<List<DbModel>> readDB()
  async {
    database = await checkDB();
    String query = "SELECT * FROM quotes";
    List<Map> l1 = await database!.rawQuery(query);
    List<DbModel> quotesList = l1.map((e) => DbModel.mapToModel(e),).toList();
    return quotesList;
  }



 void deleteDB() {}
}
