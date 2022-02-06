import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget{
  const AddCategory({Key? key}): super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Text("Category Setting")
            ),
            Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(Icons.check),
                )
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Category Name"
          ),
        )
      ),
    );
  }
}
