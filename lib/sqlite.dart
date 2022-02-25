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
      'incomeExpense TEXT,'
      'name TEXT)'
    );
    await db.execute('CREATE TABLE TRANSACTIONS (transactionId INTEGER PRIMARY KEY,'
        'category TEXT,'
        'amount INTEGER,'
        'date TEXT,'
        'time TEXT,'
        'remark TEXT,'
        'incomeExpense TEXT)'
    );
    await db.execute('CREATE TABLE VARIABLES (variableId INTEGER PRIMARY KEY,'
        'variable TEXT,'
        'amount INTEGER,'
        'category TEXT)'
    );
  }

  static initDb() async{
    String folderPath = await getDatabasesPath();
    String path = join(folderPath, "budget.db");
    //await deleteDatabase(path);
    var dbClient = await openDatabase(
      path,
      version: 2,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
    _db = dbClient;
    return dbClient;
  }


  /*static Future<dynamic> alterCategory(String categories, String columnName) async{
    var dbClient = await db;
    var count = await dbClient.execute("ALTER TABLE $categories ADD "
        "COLUMN $columnName TEXT;");
    return count;
  }*/

  //Inserting into tables
  static Future<int?> insertTransaction(Map<String, dynamic> newTransaction) async{
    var dbClient = await db;
    int id = await dbClient.insert("TRANSACTIONS", newTransaction);
    if(id != 0){
      return (id);
    }
    else{
      return (null);
    }
  }

  static Future<int?> insertCategory(Map<String, dynamic> newCategory) async{
    var dbClient = await db;
    int catId = await dbClient.insert("CATEGORIES", newCategory);
    if(catId != 0){
      return (catId);
    }
    else{
      return (null);
    }
  }

  static Future<int?> insertVariable(Map<String, dynamic> newVariable) async{
    var dbClient = await db;
    int varId = await dbClient.insert("VARIABLES", newVariable);
    if(varId != 0){
      return (varId);
    }
    else{
      return (null);
    }
  }

  //Reading from tables
  static Future<List<Transactions>> getAllTransactions() async{
    var dbClient = await db;
    List<Map<String, dynamic>> transactionsFromDB = await dbClient.query("TRANSACTIONS");
    List<Transactions> transactionsAsObject = [];
    for (var map in transactionsFromDB){
      transactionsAsObject.add(Transactions.fromMap(map));
    }
    return (transactionsAsObject);
  }

  static Future<List<Categories>> getAllCategories() async{
    var dbClient = await db;
    //await Future.delayed(Duration(seconds: 1));
    List<Map<String, dynamic>> categoriesFromDB = await dbClient.query("CATEGORIES");
    List<Categories> categoriesAsObject = [];
    for (var map in categoriesFromDB){
      categoriesAsObject.add(Categories.fromMap(map));
    }
    return (categoriesAsObject);
  }

  static Future<List<Variables>> getAllVariables() async{
    var dbClient = await db;
    //await Future.delayed(Duration(seconds: 1));
    List<Map<String, dynamic>> variablesFromDB = await dbClient.query("VARIABLES");
    List<Variables> variablesAsObject = [];
    for (var map in variablesFromDB){
      variablesAsObject.add(Variables.fromMap(map));
    }
    return (variablesAsObject);
  }

  //Updating tables
  static Future<bool> updateTransaction(Transactions transaction) async{
    var dbClient = await db;
    int changes = await dbClient.update("TRANSACTIONS",
        transaction.toMap(),
        where: "transactionId = ?",
        whereArgs: [transaction.transactionId]);
    return (changes>0);
  }

  static Future<bool> updateCategory(Categories category) async{
    var dbClient = await db;
    int changes = await dbClient.update("CATEGORIES",
        category.toMap(),
        where: "categoryId = ?",
        whereArgs: [category.categoryId]);
    return (changes>0);
  }

  static Future<bool> updateVariable(Variables variable) async{
    var dbClient = await db;
    int changes = await dbClient.update("VARIABLES",
        variable.toMap(),
        where: "variable = ?",
        whereArgs: [variable.variable]);
    return (changes>0);
  }

  //Deleting from tables
  static Future<bool> deleteTransaction(Transactions transaction) async{
    var dbClient = await db;
    int changes = await dbClient.delete("TRANSACTIONS",
        where: "transactionId = ?",
        whereArgs: [transaction.transactionId]);
    return (changes == 1);
  }

  static Future<bool> deleteCategory(Categories category) async{
    var dbClient = await db;
    int changes = await dbClient.delete("CATEGORIES",
        where: "categoryId = ?",
        whereArgs: [category.categoryId]);
    return (changes == 1);
  }

  static Future<bool> deleteVariable(Variables variable) async{
    var dbClient = await db;
    int changes = await dbClient.delete("VARIABLES",
        where: "variableId = ?",
        whereArgs: [variable.variableId]);
    return (changes == 1);
  }


}