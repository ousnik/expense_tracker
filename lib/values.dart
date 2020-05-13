import 'expense_item.dart';

int totalExpense = 0;
  
var categoryExpense = {'Food':0,'Travel':0,'Daily Needs':0,'Miscellaneous':0,'Income':0};

void manageExpenseFunc(){

  for (int i=0;i<expenseList.length;i++)
    categoryExpense[expenseList[i].category]+=expenseList[i].amount;

  totalExpense = categoryExpense.values.reduce((a, b) => a + b);
  totalExpense-=categoryExpense['Income'];

}