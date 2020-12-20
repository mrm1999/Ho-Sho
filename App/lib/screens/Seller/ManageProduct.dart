import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/screens/Seller/AddProduct.dart';
import 'package:DesiMartProto/screens/Seller/SellerHomeScreen.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  List<Item> items;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Manage your Products',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductScreen())),
                child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 80.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items != null ? items.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return _listTile(items[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTile(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 10.0,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              child: Container(
                width: 150.0,
                child: Image.network(
                  item.photoURL,
                  width: 150.0,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Price : ₹' + item.price.toString(),
                  style: TextStyle(fontSize: 16.0),
                ),
                RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Publish Advertisement'),
                            content: Text('Are you sure you want to publish an ad? This will cost you 5 HoSho coins for 20 minute on-screen time.'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SellerHomeScreen()), (route) => false), 
                                child: Text("ACCEPT")
                              ),
                              FlatButton(
                                onPressed: () => Navigator.of(context).pop(), 
                                child: Text("CANCEL")
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Add to Advertisement',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
