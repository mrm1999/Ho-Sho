import 'dart:ui';

import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/screens/Cart/CartScreen.dart';
import 'package:flutter/material.dart';

import 'ShopScreen.dart';

class ProductScreen extends StatefulWidget {
  final Item item;
  ProductScreen(this.item);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(),
                Image.network(widget.item.photoURL),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    widget.item.description,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'RATING : ',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.item.rating.toString() + '/10'),
                          Text(
                            'Based on 15 reviews',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'More Products from ',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopScreen(widget.item.shopName))),
                        child: Text(
                          widget.item.shopName,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.0,
                ),
                Text(
                  'COMMENTS',
                  style: TextStyle(fontSize: 22.0),
                ),
                populateComments(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ADD TO CART',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  onPressed: null)
            ],
          ),
        ),
      ),
    );
  }

  Widget populateComments() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.item.comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.comments[index].buyer,
                    style: TextStyle(fontSize: 20.0, color: Colors.black87),
                  ),
                  Text(
                    'Rated : ' +
                        widget.item.comments[index].ratingGiven.toString() +
                        '/10',
                    style: TextStyle(fontSize: 13.0, color: Colors.grey),
                  ),
                  Text(
                    widget.item.comments[index].description,
                    style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
          ],
        );
      },
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          Column(
            children: [
              Text(widget.item.shopName),
              Text(
                widget.item.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Theme.of(context).accentColor),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black54,
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()))),
        ],
      ),
    );
  }
}
