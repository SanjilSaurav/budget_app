import 'package:budget_app/data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_app/sqlite.dart';
import 'routing.dart' as routing;

class AddExpenseIncome extends StatefulWidget{
  const AddExpenseIncome({Key? key}) : super(key: key);

  @override
  _AddExpenseIncomeState createState() => _AddExpenseIncomeState();
}

class _AddExpenseIncomeState extends State<AddExpenseIncome>{
  //var date = DateTime.now().toString();
  //var date = DateFormat.yMMMd().format(DateTime.now()).toString();
  //var time = DateFormat.jm().format(DateTime.now()).toString();
  static String cat = "category";
  //double amount= 0;
  //String remark ="";
  static String incomeExpense = "";
  //var dateFormat = new DateFormat('yyyy-MM-dd');
  //String todayDate = dateFormat.format(date);

  void stateUpdate(){
    setState(() {

    });
  }
  Transactions transaction = Transactions(
      category: cat,
      amount: 0,
      incomeExpense: incomeExpense,
      transactionId: -1,
      date: "",
      time: ""
  );

  void addNewTransaction() async{
    Map<String, dynamic> transactionAsMap = transaction.toMap();
    transactionAsMap.remove("transactionId");
    int? transactioinId = await SqliteDb.insertTransaction(transactionAsMap);
    if(transactioinId == null){
      print("Failed");
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, routing.myHomePageId, (route) => false);
      print("success");
    }
  }

  void createBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return CreateBottomSheet();
        }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check,
          size: 25,
        ),
        onPressed: addNewTransaction,
      ),
      body:Builder(
        builder: (context) {
          return Column(
            children: [
              Container(
                height: 90,
                padding: const EdgeInsets.all(20),
                color: Colors.blue,
                child: Row(
                  children: [
                    RaisedButton(
                      onPressed: createBottomSheet,
                      /*onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return CreateBottomSheet();
                            }
                        );
                      },*/
                      child: Text(cat,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: TextField(
                          onChanged: (String value){
                            transaction.amount = double.parse(value);
                          },
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: OutlineInputBorder(),
                          ),
                        )
                    ),
                  ],
                ),

              ),
              Container(padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(cat);
                        setState(() {
                          transaction.date = DateFormat.yMMMd().format(DateTime.now()).toString();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Date:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(transaction.date),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.navigate_next),
                            ),
                            //Icon(Icons.navigate_next,),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print(incomeExpense);
                        setState(() {
                          transaction.time = DateFormat.jm().format(DateTime.now()).toString();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Icon(Icons.access_time,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Time:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(transaction.time),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.navigate_next),
                            ),
                            //Icon(Icons.navigate_next,),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 45,
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Remark: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextField(
                              onChanged: (String? value){
                                transaction.remark = value ?? transaction.remark;
                              },
                              decoration: InputDecoration(
                                hintText: "Write a note",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*Flexible(
              child: CreateBottomSheet()
            )*/
            ],
          );
        }
      )


    );
  }

}

class CreateBottomSheet extends StatefulWidget{
  const CreateBottomSheet({Key? key}): super(key: key);

  @override
  _CreateBottomSheetState createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet>{
  //_AddExpenseIncomeState cat = _AddExpenseIncomeState();
  bool isExpense = true;

  Future<List<Categories>> categoriesList = SqliteDb.getAllCategories();

  Widget futureBuilderCat(){
    return(FutureBuilder<List<Categories>>(
      future: categoriesList,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          var data = snapshot.data;
          List<Widget> expenseChildren = [];
          List<Widget> incomeChildren = [];
          for(var cat in data){
            if(cat.incomeExpense == "Expense"){
              expenseChildren.add(
                  GestureDetector(
                      child: CategoryCard(
                        category: cat.name,
                      ),
                    onTap: (){
                        _AddExpenseIncomeState.cat = cat.name;
                        _AddExpenseIncomeState.incomeExpense = cat.incomeExpense;
                        Navigator.pop(context);
                    },
                  )
              );
            }
            else{
              incomeChildren.add(
                  GestureDetector(
                    child: CategoryCard(
                      category: cat.name,
                    ),
                    onTap: (){
                      _AddExpenseIncomeState.cat = cat.name;
                      _AddExpenseIncomeState.incomeExpense = cat.incomeExpense;
                      Navigator.pop(context);
                    },
                  )
              );
            }
          }
          if(isExpense){
            return ListView(
              children: expenseChildren,
            );
          }
          else{
            return ListView(
              children: incomeChildren,
            );
          }
          /*return ListView(
            children: expenseChildren,
          );*/
        }
        else if(snapshot.hasError){
          return Text("I have error data");
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
    //return [Container()];
  }


  @override
  Widget build(BuildContext context){
    return Column(
      children:[
        Container(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isExpense = true;
                    });
                  },
                  child: Center(
                    child: Text("Expense",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        backgroundColor: isExpense ? Colors.grey : Colors.white,
                      ),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isExpense = false;
                    });

                  },
                    child: Center(
                      child: Text("Income",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          backgroundColor: isExpense ? Colors.white: Colors.grey,
                        ),
                      ),
                    ),
                ),
                flex: 1,
              )
            ],
          ),
        ),
        Flexible(
            child: futureBuilderCat()
        ),
        /*ListView(
          children: [
            GestureDetector(
              child: CategoryCard(category: "Food"),
              onTap: (){
                _AddExpenseIncomeState.cat = "Food";
                //cat.stateUpdate();
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: CategoryCard(category: "Fruits"),
              onTap: (){
                _AddExpenseIncomeState.cat = "Fruits";
                //cat.stateUpdate();
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: CategoryCard(category: "Transportation"),
              onTap: (){
                _AddExpenseIncomeState.cat = "Transportation";
                //cat.stateUpdate();
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: CategoryCard(category: "Gym"),
              onTap: (){
                _AddExpenseIncomeState.cat  = "Gym";
                //cat.stateUpdate();
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: CategoryCard(category: "Gifts"),
              onTap: (){
                _AddExpenseIncomeState.cat = "Gifts";
                //cat.stateUpdate();
                Navigator.pop(context);
              },
            ),
            GestureDetector(
              child: CategoryCard(category: "Travel"),
              onTap: (){
                _AddExpenseIncomeState.cat = "Travel";
                //cat.stateUpdate();
                Navigator.pop(context);
                setState(() {

                });
              },
            ),
          ],
        ),*/
      ]
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
            /*const Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(Icons.edit),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}