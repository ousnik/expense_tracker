import 'expense_item.dart';

int totalExpense = 0;

List<String> categoryList = 
  [
    'Entertainment',
    'Home',
    'Transportation',
    'Utilities',
    'Health',
    'Miscellaneous',
    'Income'
  ];

Map listToZeroMap(List l){
  Map m={};
  l.forEach((val) {
    m[val]=0;
  });
  return m;
}

Map categoryExpense = listToZeroMap(categoryList);

void manageExpenseFunc(){

  for (int i=0;i<expenseList.length;i++){
    
    categoryExpense[expenseList[i].category]+=expenseList[i].amount;
    
    if (expenseList[i].category=='Income')
      continue;
    else
      totalExpense+=expenseList[i].amount;
  }

}