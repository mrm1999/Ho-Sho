import 'package:DesiMartProto/classes/Cart.dart';
import 'package:DesiMartProto/classes/Item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'CheckOutScreen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // int size;
  // Cart cart;
  // List<int> quantity;
  List<Item> items;
  List<int> quantity;
  bool needDelivery = false;
  double total = 0.0;
  double currBalance;
  double deliveryCharge = 60;

  void initState() {
    super.initState();
    // cart = Cart();
    // size = cart.products.length;
    // quantity = List<int>();
    currBalance = 10000.0;
    items = List<Item>();
    items.add(Item(
        'Mango Pickle',
        'Pickles Factory',
        'Mango pickle made at home, freshly prepared with low fat oil and completely healthy. Very tasty and delivery services available, order 24 hours before the expected delivery.',
        'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/mango-pickle-recipe-9-500x500.jpg',
        156.00));
    items.add(Item(
        'Moong Papad',
        'Shaam\'s Papad',
        'Very tasty home-made moong papad',
        'https://content3.jdmagicbox.com/comp/def_content/papad-manufacturers/wmaajelcmm-papad-manufacturers-3-nmyjx.jpg?clr=442222',
        70.00));
    items.add(Item(
        'Red Spice',
        'Spice House',
        'Perfectly colored and grained home-made spices',
        'https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=2000&h=2000&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F9%2F2017%2F06%2Fred-chilli-powder-red-spices-fwx-2000.jpg',
        234.00));
    items.add(Item(
        'Butterscotch Cake',
        'Fantasy Bakery',
        'Tasty Butterscotch cake available for delivery',
        'https://d3cif2hu95s88v.cloudfront.net/live-site-2016/product-image/010/05-05-2018/1568382344IMG_8082-600x600.jpg',
        250.00));
    items.add(Item(
        'Chocolate Cake',
        'Fantasy Bakery',
        'Tasty Chocolate cake available for delivery',
        'https://www.mybakingaddiction.com/wp-content/uploads/2011/10/lr-0953-720x540.jpg',
        300.00));
    quantity = [1, 1, 1, 1, 1];
    for (var item in items) {
      total += item.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Your Cart',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: items != null ? items.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return _createTile(items[index], index);
          }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opt for Delivery',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Switch(
                      onChanged: (bool value) {
                        setState(() {
                          needDelivery = value;
                          if (needDelivery)
                            total += deliveryCharge;
                          else
                            total -= deliveryCharge;
                        });
                      },
                      value: needDelivery,
                      activeTrackColor: Colors.lightBlueAccent,
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (total > currBalance) {
                            Fluttertoast.showToast(
                                msg: 'You do not have enough credits');
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        CheckoutScreen(total, currBalance)));
                          }
                        },
                        child: Text(
                          'Checkout Now',
                          style: TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        )),
                    Text(
                      'Total : ₹' + total.toString(),
                      style: TextStyle(fontSize: 20.0, color: Colors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTile(Item item, int index) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80.0,
              child: Center(
                child: Image.network(
                  item.photoURL,
                  width: 80.0,
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
                  item.shopName,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_drop_up,
                    size: 40.0,
                  ),
                  onPressed: () {
                    if (quantity[index] > 1) {
                      setState(() {
                        quantity[index]--;
                        total -= item.price;
                      });
                    }
                  },
                ),
                Text(
                  ' ' + quantity[index].toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 40.0,
                  ),
                  onPressed: () {
                    if (quantity[index] < 10) {
                      setState(() {
                        quantity[index]++;
                        total += item.price;
                      });
                    }
                  },
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 30.0,
              ),
              onPressed: () {
                items.removeAt(index);
                quantity.removeAt(index);
              },
            )
          ],
        ),
      ),
    );
  }
}
