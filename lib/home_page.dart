import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/expense_item.dart';
import 'add_expense.dart';
import 'values.dart';

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

  Color categoryBgColour(String title){
    if (title=='Income')
      return Colors.lightGreen;
    else
      return Colors.black26;
  }
  
  Container homeCategoryTemplate(mb,icon, title){
    return Container(
              margin: EdgeInsets.only(bottom: mb),
              decoration: new BoxDecoration(
                color: categoryBgColour(title),
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Icon(icon, color: Colors.black,),
                title: Text(
                  title, 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 18
                  ),
                ),
                trailing: Text(
                  '₹'+categoryExpense[title].toString(), 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 18
                  ),
                ),
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
            Text(
              'Your Expenditure as of '+DateFormat('dd MMMM').format(expenseList[0].date).toString()+":",
              style: new TextStyle(
                fontSize: 18,
              ),
            ),Text(
              '₹'+totalExpense.toString(),
              style: new TextStyle(
                fontSize: 70,
              ),
            ),
            homeCategoryTemplate(4.00,Icons.restaurant,'Food'),
            homeCategoryTemplate(4.00,Icons.directions_transit,'Travel'),
            homeCategoryTemplate(4.00,Icons.home,'Daily Needs'),
            homeCategoryTemplate(4.0,Icons.category,'Miscellaneous'),
            homeCategoryTemplate(16.00,Icons.attach_money,'Income'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.black,),
                  heroTag: 'add_fab',
                  elevation: 4.0,
                  backgroundColor: Color(0xFFF8BBD0),
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
                  child: Icon(Icons.list, color: Colors.black,),.
                  heroTag: 'history_fab',
                  elevation: 4.0,
                  backgroundColor: Color(0xFFF8BBD0),
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
