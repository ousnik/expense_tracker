import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense_item.dart';
import 'values.dart';

class AddExpensePage extends StatefulWidget {

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {


  final addExpenseTitleController = TextEditingController();
  final addExpenseAmountController = TextEditingController();
  final addExpenseDateController = TextEditingController();
  
  static DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(DateTime.now().year-2),
      lastDate: new DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
        dateStr = DateFormat('y-MM-dd').format(picked).toString();
        addExpenseDateController.text=dateStr;
      });
    }
  }

  String category;

  static String dateStr=DateFormat('y-MM-dd').format(_date).toString();

  @override
  void dispose() {
    addExpenseTitleController.dispose();
    addExpenseAmountController.dispose();
    addExpenseDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
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
                hintText: 'Enter a title'
              ),
            ),
            TextFormField(
              controller: addExpenseAmountController,
              enableSuggestions: false,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Amount',   
                hintText: 'Enter an amount',
                prefixText: '₹',
              ),
            ),
            InkWell(
              child: IgnorePointer(
                child: TextFormField(
                  controller: addExpenseDateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today)
                  ),
                ),
              ),
              onTap: () => _selectDate(context),
            ),
            Divider(color: Colors.transparent,),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: category,
                items: categoryList.map((String value) {
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
              ),
            ),
            Divider(color: Colors.transparent,),
            MaterialButton(
             child: Text(
               "ADD",
                style: new TextStyle(
                  color: Colors.white
                )
              ),
             color: Theme.of(context).accentColor,
             elevation: 4.0,
             onPressed: () {
               addExpenseItem(
                 _date, 
                 addExpenseTitleController.text, 
                 int.parse(addExpenseAmountController.text),
                 category
                );
                if (Navigator.canPop(context)) 
                  Navigator.pop(context);
             },
           ),
          ],
        ),
      ),
    );
  }
}