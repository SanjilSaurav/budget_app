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

  String incomeExpense = "Income";
  String name = "";
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
                    onTap: ()async {
                      Map<String, dynamic> category = {
                        "name": name,
                        "incomeExpense": incomeExpense,
                      };
                      int? categoryId = await SqliteDb.insertCategory(category);
                      if (categoryId == null){
                        print("Failed");
                      }
                      else{
                        print("Success");
                        Navigator.pushNamedAndRemoveUntil(
                            context, routing.categorySettingId, (route) => false);
                      }
                    },
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
                name = value ?? name;
              },
              decoration: const InputDecoration(
                hintText: "Category Name"
              ),
            ),
            TextField(
              onChanged: (String? value){
                print("chaged2");
                incomeExpense = value ?? incomeExpense;
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
