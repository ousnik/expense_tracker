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
    expenseList.sort((a,b) => b.date.compareTo(a.date));
  }

  Color getColor(String category) {
    if (category !='Income') return Colors.red;
    else return Colors.green;
  }

  IconData getIcon(String category) {
    if (category == 'Food') return Icons.restaurant;
    else if (category == 'Travel') return Icons.directions_transit;
    else if (category == 'Daily Needs') return Icons.home;
    else if (category == 'Miscellaneous') return Icons.category;
    else if (category == 'Income') return Icons.attach_money;
    return null;
  }

  Widget expenseHistoryTitle(){
    return Padding(
      padding: const EdgeInsets.only(top:40.0,bottom: 40.0),
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
        title: Text('MY EXPENSES'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: expenseFormatter(expenseList),
      ),
    );
  }

}
