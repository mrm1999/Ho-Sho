import 'package:DesiMartProto/screens/Buyer/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends StatefulWidget {
  final double total, currBalance;
  CheckoutScreen(this.total, this.currBalance);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'TOTAL BILL : ₹' + widget.total.toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'CURRENT BALANCE : ₹' + widget.currBalance.toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    'CONFIRM PAYMENT',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: '₹' +
                            widget.total.toString() +
                            ' deducted from your wallet...');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                        (route) => false);
                  },
                ),
                Icon(
                  Icons.payment,
                  size: 40.0,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
