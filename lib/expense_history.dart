import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_item.dart';

class ExpenseHistoryPage extends StatefulWidget {

  @override
  _ExpenseHistoryPageState createState() => _ExpenseHistoryPageState();
}

class _ExpenseHistoryPageState extends State<ExpenseHistoryPage> {

  @override
  void initState() {
    super.initState();
    if(expenseList.length!=0)
      expenseList.sort((a,b) => b.date.compareTo(a.date));
  }

  Color getColor(String category) {
    if (category !='Income') return Colors.red;
    else return Colors.green;
  }

  IconData getIcon(String category) {
    switch (category) {
      case 'Entertainment': return Icons.theaters;
      case 'Health': return Icons.local_hospital;
      case 'Home': return Icons.home;
      case 'Miscellaneous': return Icons.category;
      case 'Transportation': return Icons.directions_transit;
      case 'Utilities': return Icons.build;
      case 'Income': return Icons.attach_money;
      default: return null;
    }
  }

  Widget expenseHistoryTitle(){
    return Padding(
      padding: const EdgeInsets.only(top:30.0,bottom: 30.0),
      child: Text(
        'My Expenses',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
    );
  }
  
  Widget expenseItem(List list, int index){

    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 12.0),
      child: Row(
        children: <Widget>[
          Text(
             DateFormat('dd MMM').format(list[index].date).toString(),
            style: TextStyle(
              color: Colors.blueGrey
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: Icon(getIcon(list[index].category), color: Colors.grey, size: 16.00 ),
          ),
          Expanded(flex: 1, child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(list[index].title),
          )),
          Text('₹'+list[index].amount.toString(), style: TextStyle(color: getColor(list[index].category)),),
        ],
      ),
    );
  }

  Widget monthCard(String month, String year,List passablelist) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        elevation: 10.0,
        child: ExpansionTile(
          title: Text(month+' '+year),
          children: _createChildren(passablelist),
        ),
      ),
    );
  }

  List<Widget> _createChildren(List list) {
    return new List<Widget>.generate(list.length, (int index) {
      return expenseItem(list, index);
    });
  }

  List<Widget> expenseFormatter(List expenselist){

    List<Widget> monthWidgetList=[];
      
    monthWidgetList.add(expenseHistoryTitle());

    if (expenselist.length==0){
      monthWidgetList.add(
        Center(
          heightFactor: 30,
          child: Text(
            'You have not added any expenses',
            style: TextStyle(
              color: Colors.black38
            ),
          ),
        ) 
      );
      return monthWidgetList;
    }
    int index=0;
    List<Item> passablelist =[];
    String currentMonth=expenselist[index].date.month.toString();
    String currentMonthTitle=DateFormat('MMMM').format(expenseList[index].date).toString();
    String currentYear=expenselist[index].date.year.toString();
    while(index<expenselist.length)  {
      if (DateFormat('M y').format(expenseList[index].date).toString()==
            currentMonth.toString()+' '+currentYear.toString()) {
        passablelist.add(expenselist[index]);
      }	
      else{
        monthWidgetList.add(monthCard(currentMonthTitle,currentYear,passablelist));
        passablelist=[];
        currentMonth=expenselist[index].date.month.toString();
        currentMonthTitle=DateFormat('MMMM').format(expenseList[index].date).toString();
        currentYear=expenselist[index].date.year.toString();
        index--;
      }
      index++;
    }

    monthWidgetList.add(monthCard(currentMonthTitle,currentYear,passablelist));

    return monthWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
      ),
      body: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: expenseFormatter(expenseList),
        ),
      ),
    );
  }

}
