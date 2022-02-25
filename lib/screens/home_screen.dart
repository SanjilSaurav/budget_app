import 'package:flutter/material.dart';
//import 'package:budget_app/screens/add_expense_income.dart';
import 'routing.dart';
//import 'category_setting.dart';
import 'package:budget_app/sqlite.dart';
import 'package:budget_app/data_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//enum TabItem {green, red, blue}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int expenses = 80;
  int budget = 0;
  int income = 0;
  int remainingBudget = 0;
  GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey<ScaffoldState>();
  Future<List<Transactions>> transactionList = SqliteDb.getAllTransactions();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  Widget futureBuilderTransaction(){
    return(FutureBuilder<List<Transactions>>(
      future: transactionList,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        /*var data = snapshot.data;
        List<Widget> children = [];
        for(var trans in data){
          children.add(ExpenseIncomeCard(category: trans.incomeExpense, amount: trans.amount));
        }
        return ListView(
          children: children,
        );
      }*/
        if(snapshot.hasData){
          var data = snapshot.data;
          List<Widget> children = [];
          for(var cat in data){
            children.add(ExpenseIncomeCard(category: cat.category, amount: cat.amount));
          }
          return ListView(
            children: children,
          );
        }
        else if(snapshot.hasError){
          //print(transactionList);
          return Text("I have error data");
        }
        else{
          return Text("Waiting");
        }
      },
    ));
  }

  void _onTapped(int index){
    setState(() {
      if(index == 0){
        _scaffoldKEy.currentState?.openDrawer();
      }
      if(index==1){
        Navigator.pushNamed(context, categorySettingId);
      }
      if(index==2){
        Navigator.pushNamed(context, chartId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKEy,
      drawer: SideDrawer(),
      /*appBar: AppBar(
        title: Text("Hello"),
      ),*/
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 70, left: 10),
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                          Text("------",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(" Balance",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("$expenses",
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Expenses: ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("$expenses",
                            style: const TextStyle(fontSize: 25, color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Income: ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text("$income",
                            style: const TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: GestureDetector(
                    onTap: (){
                      print("Go to amount setting");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Budget: "),
                              Text("$budget",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const LinearProgressIndicator(
                            backgroundColor: Colors.red,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            value: 60.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Remaining Budget: "),
                              Text("$remainingBudget",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          Flexible(
            child: futureBuilderTransaction(),
            /*ListView(
              children: [
                ExpenseIncomeCard(category: "Food", amount: 400),
                ExpenseIncomeCard(category: "Travel", amount: 800),
                ExpenseIncomeCard(category: "Shopping", amount: 720),
                ExpenseIncomeCard(category: "Salary", amount: 1200),
              ],
            ),*/
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, addExpenseIncomeId);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_rounded),
              label: 'Charts'
          ),
        ],
        onTap: _onTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          const Text("VIP",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.remove_done),
            title: const Text('Remove all Ads',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: const Text('Switch Colors',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.explicit_outlined),
            title: const Text('Excel Export',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: const Text('Dark Theme',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: const Text('Search',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          const Divider(thickness: 2,),
          ListTile(
            leading: Icon(Icons.restore_from_trash),
            title: const Text('Backup/Restore',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.cached_rounded),
            title: const Text('Check Update',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: const Text('Grade',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: const Text('Share',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Setting',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class ExpenseIncomeCard extends StatelessWidget{
  ExpenseIncomeCard({
    required this.category,
    required this.amount,
    Key? key,
  }): super(key: key);
  final String category;
  final int amount;

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
    child: GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        child: Row(
          children: [
            Expanded(
                child: Text(category)
            ),
            Expanded(
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text('$amount'),
                )
            ),
          ],
        ),
      )
    )
    );
  }
}