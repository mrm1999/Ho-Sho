import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/classes/Transaction.dart';
import 'package:DesiMartProto/screens/Seller/ProfileByIDScreen.dart';
import 'package:flutter/material.dart';

class ActiveOrderScreen extends StatefulWidget {
  @override
  _ActiveOrderScreenState createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
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
        156.00));
    items.add(Item(
        'Cucumber Pickle',
        'Pickles Factory',
        'Very tasty home-made cucumber pickle',
        'https://www.thebossykitchen.com/wp-content/uploads/2017/10/Pickled-Cucumbers-In-Vinegar-Easy-Recipe-1-720x540.jpg',
        260.00));
    items2 = List<Item>();
    items2.add(Item(
        'Mango Pickle',
        'Pickles Factory',
        'Mango pickle made at home, freshly prepared with low fat oil and completely healthy. Very tasty and delivery services available, order 24 hours before the expected delivery.',
        'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/mango-pickle-recipe-9-500x500.jpg',
        156.00));
    transactions = List<Transaction>();
    transactions.add(Transaction(200.0, items, quantity));
    transactions.add(Transaction(130.0, items2, quantity2));
    transactions.add(Transaction(200.0, items, quantity));
    transactions.add(Transaction(130.0, items2, quantity2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Active Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            return _createOrderTile(transactions[index]);
          }),
    );
  }

  Widget _createOrderTile(Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Card(
        elevation: 10.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 150.0,
                  child: ListView.builder(
                      itemCount: transaction.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          tileColor: Colors.grey.withOpacity(0.2),
                          title: Text(transaction.items[index].name),
                          subtitle: Text('Quantity : ' +
                              transaction.quantity[index].toString()),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProfileByIDScreen(transaction.buyerID)));
                      },
                      child: Text(
                        'Buyer Details',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Text('Total Amount : ₹' + transaction.amount.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.green.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'ACCEPT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.red.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
