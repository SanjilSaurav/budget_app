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
  var date = DateFormat.yMMMd().format(DateTime.now()).toString();
  var time = DateFormat.jm().format(DateTime.now()).toString();
  String category = "Food";
  double amount= 0;
  String remark ="";
  String incomeExpense = "Expense";
  //var dateFormat = new DateFormat('yyyy-MM-dd');
  //String todayDate = dateFormat.format(date);

  void stateUpdate(){
    setState(() {

    });
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
        onPressed: () async{
          Map<String, dynamic> transaction = {
            "amount": amount,
            "remark": remark,
            "date": date,
            "time": time,
            "category": category,
            "incomeExpense": incomeExpense
          };
          int? transactionId = await SqliteDb.insertTransaction(transaction);
          if(transactionId == null){
            print("Failed");
          }
          else{
            print("Success");
            Navigator.pushNamedAndRemoveUntil(context, routing.myHomePageId, (route) => false);
          }
        },
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
                      child: Text(category,
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
                            amount = double.parse(value);
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
                        print("tapped");
                        setState(() {
                          date = DateFormat.yMMMd().format(DateTime.now()).toString();
                          time = DateFormat.jm().format(DateTime.now()).toString();
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
                            Text(date),
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
                        print("tapped time");
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
                            Text(time),
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
                                remark = value ?? remark;
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
  _AddExpenseIncomeState cat = _AddExpenseIncomeState();
  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        GestureDetector(
          child: CategoryCard(category: "Food"),
          onTap: (){
            cat.category = "Food";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: CategoryCard(category: "Fruits"),
          onTap: (){
            cat.category = "Fruits";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: CategoryCard(category: "Transportation"),
          onTap: (){
            cat.category = "Transportation";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: CategoryCard(category: "Gym"),
          onTap: (){
            cat.category = "Gym";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: CategoryCard(category: "Gifts"),
          onTap: (){
            cat.category = "Gifts";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: CategoryCard(category: "Travel"),
          onTap: (){
            cat.category = "Travel";
            //cat.stateUpdate();
            Navigator.pop(context);
          },
        ),
      ],
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