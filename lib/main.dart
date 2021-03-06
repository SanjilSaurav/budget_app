import 'package:budget_app/screens/category_setting.dart';
import 'package:budget_app/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/screens/add_expense_income.dart';
import 'screens/routing.dart' as routing;
import 'screens/home_screen.dart';
import 'screens/chart_screen.dart';
import 'screens/add_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print(SqliteDb.getAllCategories());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        routing.myHomePageId: (context) => MyHomePage(title: "Budget"),
        routing.addExpenseIncomeId: (context) => AddExpenseIncome(),
        routing.categorySettingId: (context) => CategorySetting(),
        routing.chartId: (context) => Chart(),
        routing.addCategoryId: (context) => AddCategory(),
        //routing.transactionDetailId: (context) => TransactionDetails(),
        }
    );
  }
}

