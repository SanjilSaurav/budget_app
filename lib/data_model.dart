import 'package:flutter/material.dart';

class Transactions{
  Transactions({
    required this.category,
    required this.amount,
    required this.incomeExpense,
    required this.transactionId,
    this.remark,
    required this.date,
    required this.time,
});
  String category;
  int transactionId;
  double amount;
  String date;
  String time;
  String? remark;
  String incomeExpense;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> transactionAsMap = {
      "category": category,
      "transactionId": transactionId,
      "amount": amount,
      "date": date,
      "time": time,
      "remark": remark,
      "incomeExpense": incomeExpense
    };
    return (transactionAsMap);
  }

  static Transactions fromMap(Map<String, dynamic> transactionAsMap){
    Transactions transactions = Transactions(
      category: transactionAsMap["category"],
      transactionId: transactionAsMap["transactionId"],
      amount: transactionAsMap["amount"],
      date: transactionAsMap["date"],
      time: transactionAsMap["time"],
      remark: transactionAsMap["remark"],
      incomeExpense: transactionAsMap["incomeExpense"]
    );
    return (transactions);
  }
}

class Categories{
  Categories({
    required this.name,
    required this.categoryId,
    required this.incomeExpense,
});
  int categoryId;
  String name;
  String incomeExpense;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> catAsMap = {
      "categoryId": categoryId,
      "name": name,
      "incomeExpense": incomeExpense,
    };
    return (catAsMap);
  }

  static Categories fromMap(Map<String, dynamic> catAsMap){
    Categories categories = Categories(
      categoryId: catAsMap["categoryId"],
      name: catAsMap["name"],
      incomeExpense: catAsMap["incomeExpense"],
    );
    return categories;
  }
}