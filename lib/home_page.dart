import 'package:expense_tracker/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/expense_item.dart';
import 'expense_history.dart';
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
      home: LandingPage(),
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

  String titleBuilder (List list) {
    if (list.length==0)
      return "Your Expenditure is";
    else
      return 'Your Expenditure as of '+DateFormat('dd MMMM').format(expenseList[0].date).toString()+":";
  }

  Color getCategoryBackgroundColour(String title){
    if (title=='Income')
      return Colors.lightGreen;
    else
      return Colors.black26;
  }
  
  Container homeCategoryTemplate(icon, title){
    return Container(
      decoration: new BoxDecoration(
        color: getCategoryBackgroundColour(title),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                  titleBuilder(expenseList),
              style: new TextStyle(
                fontSize: 18,
              ),
            ),Text(
              '₹'+totalExpense.toString(),
              style: new TextStyle(
                fontSize: 50,
              ),
            ),
            homeCategoryTemplate(Icons.theaters,'Entertainment'),
            homeCategoryTemplate(Icons.directions_transit,'Transportation'),
            homeCategoryTemplate(Icons.home,'Home'),
            homeCategoryTemplate(Icons.build,'Utilities'),
            homeCategoryTemplate(Icons.category,'Miscellaneous'),
            homeCategoryTemplate(Icons.local_hospital,'Health'),
            homeCategoryTemplate(Icons.attach_money,'Income'),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.black,),
                  heroTag: 'add_fab',
                  elevation: 4.0,
                  backgroundColor: Colors.cyan,
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
                  child: Icon(Icons.list, color: Colors.black,),
                  heroTag: 'history_fab',
                  elevation: 4.0,
                  backgroundColor: Colors.cyan,
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
