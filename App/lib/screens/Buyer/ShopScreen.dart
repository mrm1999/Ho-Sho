import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/screens/Cart/CartScreen.dart';
import 'package:flutter/material.dart';

import 'ProductScreen.dart';

class ShopScreen extends StatefulWidget {
  final String shop;
  ShopScreen(this.shop);
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          widget.shop,
          style: TextStyle(fontSize: 20.0),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()))),
        ],
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.70),
        itemBuilder: (BuildContext context, int index) {
          return _createItemBox(items[index]);
        },
      ),
    );
  }

  Widget _createItemBox(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProductScreen(item)));
        },
        child: Card(
          color: Colors.white.withOpacity(0.80),
          elevation: 10.0,
          shadowColor: Theme.of(context).accentColor.withOpacity(0.60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 1.0, right: 1.0),
                alignment: Alignment.topCenter,
                child: Image.network(
                  item.photoURL,
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
              ListTile(
                isThreeLine: true,
                title: Text(
                  item.name.length > 16
                      ? item.name.substring(0, 14) + '...'
                      : item.name,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "₹" +
                      item.price.toString() +
                      '\n' +
                      (item.shopName.length > 18
                          ? item.shopName.substring(0, 14) + '...'
                          : item.shopName),
                  style: TextStyle(color: Colors.black87, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
