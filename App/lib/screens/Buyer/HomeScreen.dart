import 'dart:ui';

import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:DesiMartProto/classes/Comment.dart';
import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/screens/AboutUs.dart';
import 'package:DesiMartProto/screens/Buyer/MyOrders.dart';
import 'package:DesiMartProto/screens/Buyer/SettingsBuyer.dart';
import 'package:DesiMartProto/screens/Cart/CartScreen.dart';
import 'package:DesiMartProto/screens/LogReg/EmailScreen.dart';
import 'package:DesiMartProto/screens/Seller/CreateShopScreen.dart';
import 'package:DesiMartProto/screens/Seller/SellerHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../TandCScree.dart';
import 'AdvertisementWidget.dart';
import 'BuyerProfileScreen.dart';
import 'CategoryScreen.dart';
import 'ProductScreen.dart';
import 'ProductSearch.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items;
  Comment comment;
  List<Comment> comments;
  bool isSeller = false;

  void initState() {
    super.initState();
    print(Buyer().email);
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
    items.add(Item(
        'Cucumber Pickle',
        'Pickles Factory',
        'Very tasty home-made cucumber pickle',
        'https://www.thebossykitchen.com/wp-content/uploads/2017/10/Pickled-Cucumbers-In-Vinegar-Easy-Recipe-1-720x540.jpg',
        260.00));
    items.add(Item(
        'Mango Pickle',
        'Pickles Factory',
        'Very tasty home-made mango pickle',
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
        'https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=2000&h=200&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F9%2F2017%2F06%2Fred-chilli-powder-red-spices-fwx-2000.jpg',
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

  void _pushCategory(String category) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => CategoryScreen(category)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'HoSho',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch());
              }),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen()));
              })
        ],
      ),
      drawer: _createDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pushCategory('Spice');
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            'https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=2000&h=200&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F9%2F2017%2F06%2Fred-chilli-powder-red-spices-fwx-2000.jpg',
                          ),
                        ),
                        Text('Spice'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pushCategory('Pickle'),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/03/mango-pickle-recipe-9-500x500.jpg',
                          ),
                        ),
                        Text('Pickle'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pushCategory('Snacks'),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            'https://content3.jdmagicbox.com/comp/def_content/papad-manufacturers/wmaajelcmm-papad-manufacturers-3-nmyjx.jpg?clr=442222',
                          ),
                        ),
                        Text('Snacks'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pushCategory('Cakes'),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            'https://d3cif2hu95s88v.cloudfront.net/live-site-2016/product-image/010/05-05-2018/1568382344IMG_8082-600x600.jpg',
                          ),
                        ),
                        Text('Cakes'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              child: AdvertisementWidget(items.sublist(0, 4)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.70),
              itemBuilder: (BuildContext context, int index) {
                return _createItemBox(items[index]);
              },
            ),
          ],
        ),
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

  Widget _createDrawer() {
    EdgeInsets _padding = EdgeInsets.fromLTRB(40, 15, 10, 15);
    return Drawer(
      elevation: 5.0,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                child: Text(
                  'What are you upto today?',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 15.0),
            child: InkWell(
              onTap: () {
                if (!isSeller) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateShopScreen()));
                } else {
                  // Create Seller instance
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SellerHomeScreen()),
                      (route) => false);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.store_mall_directory),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Sell on DesiMart',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () {
                Fluttertoast.showToast(
                    msg:
                        "Apply for delivery service from here. Currently, this functionality is not available.");
              },
              child: Row(
                children: [
                  Icon(Icons.delivery_dining),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Earn by Delivery',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MyOrderScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BuyerProfileScreen())),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SettingsBuyerScreen())),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => EmailScreen()),
                    (route) => false);
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AboutUs()));
              },
              child: Row(
                children: [
                  Icon(Icons.info),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: _padding,
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TandCScreen())),
              child: Row(
                children: [
                  Icon(Icons.construction),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
