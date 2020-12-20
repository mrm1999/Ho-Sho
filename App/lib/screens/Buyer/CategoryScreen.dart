import 'dart:ui';

import 'package:DesiMartProto/classes/Comment.dart';
import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/screens/Cart/CartScreen.dart';
import 'package:flutter/material.dart';

import 'ProductScreen.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  CategoryScreen(this.category);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Item> items;
  Comment comment;
  List<Comment> comments;

  void initState() {
    super.initState();
    comment = Comment(
        'Kieron Pollard',
        'Worst product I have ever had. Do not recomment it to anyone. Make at your own home it will surely be better...',
        -1);
    comments = [comment, comment, comment, comment];
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
    populateComments();
  }

  void populateComments() {
    for (var item in items) {
      item.comments = comments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(widget.category, style: TextStyle(fontSize: 20.0),),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()))),
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
