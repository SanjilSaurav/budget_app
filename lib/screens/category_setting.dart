import 'package:budget_app/data_model.dart';
import 'package:budget_app/screens/routing.dart';
import 'package:budget_app/sqlite.dart';
import 'package:flutter/material.dart';

class CategorySetting extends StatefulWidget{
  const CategorySetting({Key? key}) : super(key: key);

  @override
  _CategorySettingState createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  bool isExpense = false;

  void _tappedIncome(){
    print("Income");
    print(MediaQuery.of(context).size.width);
    setState(() {
      isExpense = false;
    });
  }
  void _tappedExpense(){
    print("expense");
    setState(() {
      isExpense = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Settings"),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.blue,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      onTap: _tappedExpense,
                      child: Container(
                        child: Text("Expenses(0)",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      onTap: _tappedIncome,
                      child: Container(
                        child: Text("Incomes(0)",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: isExpense ? const ExpensesCategories() : const IncomeCategories(),
          )
        ],
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

  Future<List<Categories>> categoriesList = SqliteDb.getAllCategories();

  Widget futureBuilderExpense(){
    return(FutureBuilder<List<Categories>>(
      future: categoriesList,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          var data = snapshot.data;
          List<Widget> children = [];
          for(var cat in data){
            if(cat.incomeExpense == "Expense"){
              children.add(CategoryCard(category: cat.name));
            }
          }
          return ListView(
            children: children,
          );
        }
        else if(snapshot.hasError){
          return Text("I have error data");
        }
        else{
          return Text("Waiting");
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: futureBuilderExpense(),
      /*ListView(
        children: const [
          CategoryCard(category: "Food"),
          CategoryCard(category: "Travel"),
          CategoryCard(category: "Clothing"),
          CategoryCard(category: "Home"),
          CategoryCard(category: "Shopping"),
          CategoryCard(category: "Gifts")
        ],
      ),*/
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.only(left: 30),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){
            Navigator.pushNamed(context, addCategoryId);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add,
              color: Colors.black,
              size: 40,
              ),
              Text("ADD CATEGORY",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ]
            )
        ),
      )
    );
  }
}

class IncomeCategories extends StatefulWidget{
  const IncomeCategories({Key? key}): super(key: key);

  @override
  _IncomeCategoriesState createState() => _IncomeCategoriesState();
}

class _IncomeCategoriesState extends State<IncomeCategories>{
  Future<List<Categories>> categoriesList = SqliteDb.getAllCategories();

  Widget futureBuilderIncome(){
    return(FutureBuilder<List<Categories>>(
      future: categoriesList,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          var data = snapshot.data;
          List<Widget> children = [];
          for(var cat in data){
            if(cat.incomeExpense == "Income"){
              children.add(CategoryCard(category: cat.name));
            }
          }
          return ListView(
            children: children,
          );
        }
        else if(snapshot.hasError){
          return Text("I have error data");
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: futureBuilderIncome(),
      /*ListView(
        children: const [
          CategoryCard(category: "Rental"),
          CategoryCard(category: "Divedends"),
          CategoryCard(category: "Crypto"),
          CategoryCard(category: "Salary"),
          CategoryCard(category: "Rewards"),
          CategoryCard(category: "Others")
        ],
      ),*/
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          width: MediaQuery.of(context).size.width,
          //padding: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: (){
                Navigator.pushNamed(context, addCategoryId);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                    Text("ADD CATEGORY",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ]
              )
          ),
        )
    );
  }
}

class CategoryCard extends StatelessWidget{
  const CategoryCard({
    required this.category,
    Key? key,
  }): super(key: key);
  final String category;

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 70,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(category,
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(Icons.edit),
              ),
            )
          ],
        ),
      ),
    );
  }
}