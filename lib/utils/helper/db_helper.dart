import 'package:db_miner/screen/home/model/quotes_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../screen/favourite/model/db_model.dart';


class DbHelper {
 static DbHelper helper = DbHelper._();
  DbHelper._();
  Database? database;

//   Future<Database> checkDB() async {
//     print("=================== 1");
//     if (database == null) {
//       print(true);
//       database = await initDB();
//     }
//     return database!;
//   }
//
//  Future<Database> initDB() async {
//    String folder = await getDatabasesPath();
//    String path = "$folder/demo.db";
// print(false);
//    return await openDatabase(
//      path,
//      version: 1,
//      onCreate: (db, version) {
//         String query1 = "CREATE TABLE q1 (cid INTEGER PRIMARY KEY AUTOINCREMENT,,quotes TEXT,author TEXT,image TEXT)";
//        // "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
//        // String query2 = "CREATE TABLE entry (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,category TEXT,amount TEXT,date INTERGER,time INTERGER,status INTERGER)";
//        // print("==============tcae");
//        db.execute(query1);
//        // db.execute(query2);
//
//      },
//    );
//    // database.execute(query);
//  }
//

  Future<Database> checkDB() async {
    if (database == null) {
       database = await initDB();
    }
    return database!;
    // else {
    //      database = await initDB();
    //      return database!;
    // }

  }

  Future<Database> initDB() async {
    String folder = await getDatabasesPath();
    String path = "$folder/demo.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query1 = "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT)";
        // "CREATE TABLE category (cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
        // String query2 = "CREATE TABLE entry (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,category TEXT,amount TEXT,date INTERGER,time INTERGER,status INTERGER)";
        db.execute(query1);
        // db.execute(query2);
      },
    );
    // database.execute(query);
  }

  Future<void> insertDB(HomeModel model1) async {
    database = await checkDB();
    database!.insert("category", {'category' :model1.name});
    // String query = "INSERT INTO category(name) VALUES('$category')";
    // await database!.rawInsert(query);
  }
  Future<List<HomeModel>> readDB() async {
    database = await checkDB();
    String query = "SELECT * FROM category";
    List<Map> l1 = await database!.rawQuery(query);
    List<HomeModel> categoryList = l1
        .map(
          (e) => HomeModel.mapToModel(e),
    )
        .toList();
    return categoryList;
  }


  // Future<void> insertDBQ({quotes, author, image}) async {
  //   database = await checkDB();
  //   // await database!.insert("q1", {"quotes": quotes,"author": author,"image": image});
  //   // print(quotes);
  //   // print("=================== 3");
  //   // String query = "INSERT INTO  q1(quotes,author,image) VALUES('$quotes','$author','$image',)";
  //   //
  //   String query = "INSERT INTO quotes(quotes,author,image) VALUES('$quotes','$author','$image')";
  //   await database!.rawInsert(query);
  // }
  // Future<List<DbModel>> readDB()
  // async {
  //   database = await checkDB();
  //   String query = "SELECT * FROM q1";
  //   List<Map> l1 = await database!.rawQuery(query);
  //   List<DbModel> quotesList = l1.map((e) => DbModel.mapToModel(e),).toList();
  //   return quotesList;
  // }



 void deleteDB() {}
}
