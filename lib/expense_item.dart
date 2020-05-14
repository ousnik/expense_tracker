import 'package:firebase_database/firebase_database.dart';

var dbReference = FirebaseDatabase.instance.reference();  

class Item{

  final DateTime date;
  final String title;
  final int amount;
  final String category;

  Item (this.date, this.title, this.amount, this.category);

}

Item getExpenseItem(Map val){
  Item mExpenseItem = new Item(
    DateTime.parse(val['date']),
    val['title'],
    val['amount'],
    val['category'],
  );
  return mExpenseItem;
}

void expenseListPopulator() async {
 await dbReference.once().then((DataSnapshot snapshot){
    Map<dynamic, dynamic> values = snapshot.value;
    if(values!=null){
      values.forEach((key,values) {
        Item check = getExpenseItem(values);
        expenseList.add(check);
      });
    }
  });
}

List<Item> expenseList = [];
 
void addExpenseItem(date,title,amount,category){
  Item newItem = new Item(date,title,amount,category);
  var newItemMap={
    'date':newItem.date.toString(),
    'title':newItem.title,
    'amount':newItem.amount,
    'category':newItem.category
  };

  dbReference.push().set(newItemMap);
  expenseList.add(newItem);

}

