import 'package:flutter/material.dart';

class CategorySetting extends StatefulWidget{
  const CategorySetting({Key? key}) : super(key: key);

  @override
  _CategorySettingState createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Settings"),
      ),
    );
  }
}

class ExpensesCategories extends StatefulWidget{
  const ExpensesCategories({Key? key}) : super(key: key);

  @override
  _ExpensesCategoriesState createState() => _ExpensesCategoriesState();
}

class _ExpensesCategoriesState extends State<ExpensesCategories>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Settings"),
      ),
    );
  }
}

class IncomeCategories extends StatefulWidget{
  const IncomeCategories({Key? key}): super(key: key);

  @override
  _IncomeCategoriesState createState() => _IncomeCategoriesState();
}

class _IncomeCategoriesState extends State<IncomeCategories>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Income Categories"),
      )
    );
  }
}