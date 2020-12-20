import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:flutter/material.dart';

class SettingsBuyerScreen extends StatefulWidget {
  @override
  _SettingsBuyerScreenState createState() => _SettingsBuyerScreenState();
}

class _SettingsBuyerScreenState extends State<SettingsBuyerScreen> {
  int balance;
  void initState() {
    super.initState();
    getBalance();
  }

  Future<void> getBalance() async {
    balance = await Buyer().getAccountBal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
          child: Column(
            children: [
              InkWell(
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
                      'Check your account balance',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
