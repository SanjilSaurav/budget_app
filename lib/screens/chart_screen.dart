import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget{
  const Chart({Key? key}): super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart>{

  bool isExpense = false;

  void tappedIncome(){
    setState(() {
      isExpense = false;
    });
  }

  void tappedExpense(){
    setState(() {
      isExpense = true;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 117,
            //color: Colors.red,
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                        size: 20,
                      ),
                      Text("  Jan 1, 2022 - Jan 31, 2022")
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children:[
                    OutlinedButton(
                      onPressed: tappedExpense,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        //backgroundColor: isExpense ? Colors.blue : Colors.grey,
                      ),
                      child: Text("Expenses",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: tappedIncome,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                      ),
                      child: Text("Income",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ]
                ),

              ],
            ),


          ),
          Flexible(
            child: isExpense ? ExpenseChart() : IncomeChart()
          )
        ],
      ),
    );
  }
}

class ExpenseChart extends StatefulWidget{
  const ExpenseChart({Key? key}): super(key: key);

  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
          ExpenseIncomeCard(category: "Food", amount: -500, count: 2),
          ExpenseIncomeCard(category: "Shopping", amount: -500, count: 2),
          ExpenseIncomeCard(category: "Transportation", amount: -500, count: 2),
          ExpenseIncomeCard(category: "Fruits", amount: -500, count: 2),
          ExpenseIncomeCard(category: "Gifts", amount: -500, count: 2),
        ],
      ),
    );
  }
}

class IncomeChart extends StatefulWidget{
  const IncomeChart({Key? key}): super(key: key);

  @override
  _IncomeChartState createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
          ExpenseIncomeCard(category: "Salary", amount: 50000000, count: 2),
          ExpenseIncomeCard(category: "Divedend", amount: 200, count: 2),
          ExpenseIncomeCard(category: "Sale", amount: 350, count: 2),
          ExpenseIncomeCard(category: "Crypto", amount: 100, count: 2),
          ExpenseIncomeCard(category: "Others", amount: 80, count: 2),
        ],
      ),
    );
  }
}

class ExpenseIncomeCard extends StatelessWidget{
  ExpenseIncomeCard({
    required this.category,
    required this.amount,
    required this.count,
    Key? key
  }):super(key: key);

  final String category;
  final int amount,count;
  double percentage = 0;

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        //color: Colors.red,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(category,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("$percentage%"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("$count count")
                    ]
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text("$amount",
                      style: TextStyle(fontSize: 20),
                    )
                  )
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.blueGrey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              value: 0,
            ),
          ],
        ),
      ),
    );
  }
}