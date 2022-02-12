import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';

class SqliteDb{
  SqliteDb.internal();
  static Database? _db;
  static Future<Database> get db async{
    if(_db != null){
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  static Future _onConfigure(Database db) async{
    await db.execute('PRAGMA foreign_keys=ON');
  }

  static Future _onCreate(Database db, int t) async{
    await db.execute('CREATE TABLE CATEGORIES (categoryId INTEGER PRIMARY KEY,'
      'name TEXT)'
    );
    await db.execute('CREATE TABLE TRANSACTIONS (id INTEGER PRIMARY KEY,'
        'category TEXT,'
        'amount INTEGER,'
        'date TEXT,'
        'time TEXT,'
        'remark TEXT,'
        'incomeExpense TEXT)'
    );
  }

  static initDb() async{
    String folderPath = await getDatabasesPath();
    String path = join(folderPath, "budget.db");

    var budgetDb = await openDatabase(
      path,
      version: 2,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
    _db = budgetDb;
    return budgetDb;
  }

  //Inserting into tables
  static Future<int?> insertTransaction(Transactions newTransaction) async{
    var budgetDatabase = await db;
    int id = await budgetDatabase.insert("TRANSACTIONS", newTransaction.toMap());
    if(id != 0){
      return (id);
    }
    else{
      return (null);
    }
  }

  static Future<int?> insertCategory(Categories newCategory) async{
    var budgetDatabase = await db;
    int catId = await budgetDatabase.insert("CATEGORIES", newCategory.toMap());
    if(catId != 0){
      return (catId);
    }
    else{
      return (null);
    }
  }

  //Reading from tables
  static Future<List<Transactions>> getAllTransactions() async{
    var budgetDatabase = await db;
    List<Map<String, dynamic>> transactionsFromDB = await budgetDatabase.query("TRANSACTIONS");
    List<Transactions> transactionsAsObject = [];
    for (var map in transactionsFromDB){
      transactionsAsObject.add(Transactions.fromMap(map));
    }
    return (transactionsAsObject);
  }

  static Future<List<Categories>> getAllCategories() async{
    var budgetDatabase = await db;
    List<Map<String, dynamic>> categoriesFromDB = await budgetDatabase.query("CATEGORIES");
    List<Categories> categoriesAsObject = [];
    for (var map in categoriesFromDB){
      categoriesAsObject.add(Categories.fromMap(map));
    }
    return (categoriesAsObject);
  }

  //Updating tables
  static Future<bool> updateTransaction(Transactions transaction) async{
    var budgetDatabase = await db;
    int changes = await budgetDatabase.update("TRANSACTIONS",
        transaction.toMap(),
        where: "transactionId = ?",
        whereArgs: [transaction.transactionId]);
    return (changes>0);
  }

  static Future<bool> updateCategory(Categories category) async{
    var budgetDatabase = await db;
    int changes = await budgetDatabase.update("CATEGORIES",
        category.toMap(),
        where: "categoryId = ?",
        whereArgs: [category.categoryId]);
    return (changes>0);
  }

  //Deleting from tables
  static Future<bool> deleteTransaction(Transactions transaction) async{
    var budgetDatabase = await db;
    int changes = await budgetDatabase.delete("TRANSACTIONS",
        where: "transactionId = ?",
        whereArgs: [transaction.transactionId]);
    return (changes == 1);
  }

  static Future<bool> deleteCategory(Categories category) async{
    var budgetDatabase = await db;
    int changes = await budgetDatabase.delete("CATEGORIES",
        where: "categoryId = ?",
        whereArgs: [category.categoryId]);
    return (changes == 1);
  }


}