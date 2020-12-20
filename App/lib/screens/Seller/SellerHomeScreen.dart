import 'package:DesiMartProto/classes/Comment.dart';
import 'package:DesiMartProto/classes/Item.dart';
import 'package:DesiMartProto/classes/Seller.dart';
import 'package:DesiMartProto/screens/AboutUs.dart';
import 'package:DesiMartProto/screens/Buyer/HomeScreen.dart';
import 'package:DesiMartProto/screens/Buyer/ProductScreen.dart';
import 'package:DesiMartProto/screens/LogReg/EmailScreen.dart';
import 'package:DesiMartProto/screens/Seller/ActiveOrderScreen.dart';
import 'package:DesiMartProto/screens/Seller/ManageProduct.dart';
import 'package:DesiMartProto/screens/Seller/ShopProfile.dart';
import 'package:DesiMartProto/screens/TandCScree.dart';
import 'package:flutter/material.dart';

import 'AddProduct.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  Seller seller;
  List<Item> items;
  Comment comment;
  List<Comment> comments;

  void initState() {
    super.initState();
    seller = Seller();
    seller.name = 'Rajesh khattar';
    seller.email = 'rajesh@gmail.com';
    seller.shopName = 'Pickle\'s Factory';
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
      appBar: _createAppBar(),
      drawer: _createDrawer(),
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

  Widget _createAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      title: Text(
        'Pickles Factory',
        style: TextStyle(fontSize: 25.0),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddProductScreen())),),
      ],
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
                  'How are you doing today?',
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
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false),
              child: Row(
                children: [
                  Icon(Icons.store_mall_directory),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Buy on Desimart',
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
                    MaterialPageRoute(builder: (_) => ActiveOrderScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'My Active Orders',
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ShopProfile()));
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Shop Profile',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ManageProduct()));
              },
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Manage Products',
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
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutUs())),
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
