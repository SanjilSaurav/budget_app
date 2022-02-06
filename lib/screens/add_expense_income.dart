import 'package:flutter/material.dart';

class AddExpenseIncome extends StatefulWidget{
  const AddExpenseIncome({Key? key}) : super(key: key);

  @override
  _AddExpenseIncomeState createState() => _AddExpenseIncomeState();
}

class _AddExpenseIncomeState extends State<AddExpenseIncome>{

  /*void createBottomSheet(){
    Scaffold.of(context).showBottomSheet<void>(BuildContext context){
      return Container(
        child: Center(
          //chil
        )
      );
    };
  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 90,
            padding: const EdgeInsets.all(20),
            color: Colors.blue,
            child: Row(
              children: [
                RaisedButton(
                  onPressed: (){
                  },
                  child: const Text("Transportation",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),
            ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Flexible(
                  child: TextField(
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
                  onTap: (){
                    print("tapped");
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 45,
                    color: Colors.grey,
                    child: Row(
                      children: const [
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
                        Text("22 feb"),
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
                  onTap: (){
                    print("tapped time");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 45,
                    color: Colors.grey,
                    child: Row(
                      children: const [
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
                        Text("8:00"),
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
                    children: const [
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
          Flexible(
            child: CreateBottomSheet()
          )
        ],
      ),
    );
  }

}

class CreateBottomSheet extends StatefulWidget{
  const CreateBottomSheet({Key? key}): super(key: key);

  @override
  _CreateBottomSheetState createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet>{
  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}