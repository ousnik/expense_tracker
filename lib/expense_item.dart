
class Item{

  final DateTime date;
  final String title;
  final int amount;
  final String category;

  Item (this.date, this.title, this.amount, this.category);

}

List<Item> expenseList =
  [
    Item(DateTime.parse('2020-03-30'), 'Salary',100, 'Income'),
    Item(DateTime.parse('2020-05-26'), 'Soap', 59, 'Daily Needs'),
    Item(DateTime.parse('2020-04-28'), 'Milk', 200, 'Food'),
    Item(DateTime.parse('2020-05-03'), 'Flight', 300, 'Travel'),
    Item(DateTime.parse('2020-05-03'), 'Chicken', 150, 'Food'),
    Item(DateTime.parse('2020-05-03'), 'abcd', 300, 'Miscellaneous'),
  ];


void addExpenseItem(date,title,amount,category){
  Item newItem = new Item(date,title,amount,category);
  expenseList.add(newItem); 
  expenseList.sort((a,b) => b.date.compareTo(a.date));
}

