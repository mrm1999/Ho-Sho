import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:flutter/material.dart';

class ShopProfile extends StatefulWidget {
  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  GlobalKey _formKey;
  int balance;
  TextEditingController _shopnameController;
  @override
  void initState() {
    super.initState();
    _shopnameController = TextEditingController(text: 'Pickle\'s Factory');
    getBalance();
  }

  Future<void> getBalance() async {
    balance = await Buyer().getAccountBal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
          title: Text(
            'Shop Profile',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300.0,
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add_business,
                        color: Colors.black,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _shopnameController,
                    decoration: InputDecoration(
                      labelText: 'Shop Name',
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Account Balance',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                              'Your account balance is ₹' + balance.toString()),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.account_balance),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Current Account Balance',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
