
class Item{

  final DateTime date;
  final String title;
  final int amount;
  final String debitOrCredit;
  final String category;

  Item (this.date, this.title, this.amount, this.debitOrCredit, this.category);

}

List<Item> expenseList =
  [
    Item(DateTime.parse('2020-03-30'), 'Salary',1200, 'Credit', 'Miscellaneous'),
    Item(DateTime.parse('2020-05-26'), 'Soap', 59, 'Debit', 'Daily Needs'),
    Item(DateTime.parse('2020-04-28'), 'Milk', 30, 'Debit', 'Food'),
    Item(DateTime.parse('2020-05-03'), 'FD', 300, 'Credit', 'Travel'),
  ];


void addExpenseItem(date,title,amount,debitOrCredit,category){
  Item newItem = new Item(date,title,amount,debitOrCredit,category);
  expenseList.add(newItem); 
  expenseList.sort((a,b) => b.date.compareTo(a.date));
}

