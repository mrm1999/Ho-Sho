import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/classes/Transaction.dart';
import 'package:flutter/material.dart';

class ActiveOrderScreen extends StatefulWidget {
  @override
  _ActiveOrderScreenState createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  @override
  Widget build(BuildContext context) {
    List<Item> items;
    List<Item> items2;
    List<int> quantity = [2, 1];
    List<int> quantity2 = [3];
    List<Transaction> transactions;
    void initState() {
      super.initState();
      items = List<Item>();
      items.add(Item(
          'Mango Pickle',
          'Pickles Factory',
          'Mango pickle made at home, freshly prepared with low fat oil and completely healthy. Very tasty and delivery services available, order 24 hours before the expected delivery.',
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/mango-pickle-recipe-9-500x500.jpg',
          156.00, '0'));
      items.add(Item(
          'Cucumber Pickle',
          'Pickles Factory',
          'Very tasty home-made cucumber pickle',
          'https://www.thebossykitchen.com/wp-content/uploads/2017/10/Pickled-Cucumbers-In-Vinegar-Easy-Recipe-1-720x540.jpg',
          260.00, '0'));
      items2 = List<Item>();
      items2.add(Item(
          'Mango Pickle',
          'Pickles Factory',
          'Mango pickle made at home, freshly prepared with low fat oil and completely healthy. Very tasty and delivery services available, order 24 hours before the expected delivery.',
          'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/mango-pickle-recipe-9-500x500.jpg',
          156.00, '0'));
      transactions = List<Transaction>();
      transactions.add(Transaction(200.0, items, quantity));
      transactions.add(Transaction(130.0, items2, quantity2));
      transactions.add(Transaction(200.0, items, quantity));
      transactions.add(Transaction(130.0, items2, quantity2));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Active Orders',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
    );
  }
}
