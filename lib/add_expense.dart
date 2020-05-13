import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_item.dart';

class AddExpensePage extends StatefulWidget {

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  static int _debitCredit;
  final int radioGroup = 1;

  @override
  void initState() {
    super.initState();
    _debitCredit = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      _debitCredit=val;
    });
  }

  String debitOrCredit(int dc){
    if (dc==1) return 'Credit';
    else return 'Debit';
  }

  final addExpenseTitleController = TextEditingController();
  final addExpenseAmountController = TextEditingController();
  
  static DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2018),
      lastDate: new DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
        dateStr = DateFormat('y-MM-dd').format(picked).toString();
      });
    }
  }

  String category;

  static String dateStr=DateFormat('y-MM-dd').format(_date).toString();

  @override
  void dispose() {
    addExpenseTitleController.dispose();
    addExpenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: addExpenseTitleController,
              enableSuggestions: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Title',   
                hintText: 'Enter Title'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _debitCredit, 
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setSelectedRadio(val);
                  },
                ),
                Text('Debit')
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _debitCredit, 
                  activeColor: Colors.green,
                  onChanged: (val) {
                    setSelectedRadio(val);
                  },
                ),
                Text('Credit'),
              ],
            ),
              ],
            ),
            TextFormField(
              controller: addExpenseAmountController,
              enableSuggestions: false,
              keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: true
              ),
              decoration: InputDecoration(
                labelText: 'Amount',   
                hintText: 'Enter Amount'
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                Text(
                  dateStr,
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ), 
              ]
            ),
            Row(
              children: [
                Text('Category: '),
                DropdownButton<String>(
                  value: category,
                  items: <String>['Food','Travel','Daily Needs','Miscellaneous'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  hint: new Text("Select Category"),
                  onChanged: (String newValue) {
                    setState(() {
                      category=newValue;
                    });
                  }
                )
              ]
            ),
            MaterialButton(
             child: Text("ADD"),
             color: Theme.of(context).accentColor,
             elevation: 4.0,
             onPressed: () {
               addExpenseItem(
                 _date, 
                 addExpenseTitleController.text, 
                 int.parse(addExpenseAmountController.text), 
                 debitOrCredit(_debitCredit), 
                 category
                );
             },
           ),
          ],
        ),
      ),
    );
  }
}