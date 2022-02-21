//import 'package:budget_app/data_model.dart';
import 'package:budget_app/data_model.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/sqlite.dart';
import 'routing.dart' as routing;

class AddCategory extends StatefulWidget{
  const AddCategory({Key? key}): super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory>{
  Categories category = Categories(
      name: "",
      categoryId: -1,
      incomeExpense: "",
  );

  void addNewCategory() async{
    Map<String, dynamic> catAsMap = category.toMap();
    catAsMap.remove("categoryId");
    int? categoryId = await SqliteDb.insertCategory(catAsMap);
    if(categoryId==null){
      print("failed");
    }
    else{
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, routing.categorySettingId);
      print("success");
    }
  }

  /*String incomeExpense = "Income";
  String name = "";*/
  @override
  Widget build(BuildContext context){
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          SqliteDb.alterCategory("CATEGORIES", "incomeExpense");
        },
      ),*/
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Text("Category Setting")
            ),
            Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    child:Icon(Icons.check),
                    onTap: addNewCategory,
                  ),
                )
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (String? value){
                print("changed");
                category.name = value ?? category.name;
              },
              decoration: const InputDecoration(
                hintText: "Category Name"
              ),
            ),
            TextField(
              onChanged: (String? value){
                print("chaged2");
                category.incomeExpense = value ?? category.incomeExpense;
              },
              decoration: const InputDecoration(
                  hintText: "Income or Expense",
              ),
            )
          ]
        )
      ),
    );
  }
}
