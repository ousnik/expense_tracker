import 'package:expense_tracker/expense_item.dart';
import 'package:flutter/material.dart';
import 'add_expense.dart';
import 'expense_history.dart';
import 'static_values.dart';

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage
        (
          title: 'Expense Tracker'
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    manageExpenseFunc();
  }
  
  Container homeCategoryTemplate(mb,icon, title){
    return Container(
              margin: EdgeInsets.only(bottom: mb),
              decoration: new BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Icon(icon, color: Colors.white,),
                title: Text(title,style: TextStyle(color: Colors.white),),
                trailing: Text('₹'+categoryExpense[title].toString(), style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              width: 150,
              height: 150,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber
              ),
              child: Center(
                child: Text(
                  '₹'+totalExpense.toString(),
                  style: new TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            homeCategoryTemplate(4.00,Icons.restaurant,'Food'),
            homeCategoryTemplate(4.00,Icons.directions_transit,'Travel'),
            homeCategoryTemplate(4.00,Icons.home,'Daily Needs'),
            homeCategoryTemplate(16.00,Icons.category,'Miscellaneous'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add),
                  heroTag: 'add_fab',
                  elevation: 4.0,
                  backgroundColor: Colors.pink,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExpensePage()
                      )
                    );                 
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.list),
                  heroTag: 'history_fab',
                  elevation: 4.0,
                  backgroundColor: Colors.pink,
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ExpenseHistoryPage()
                      )
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
