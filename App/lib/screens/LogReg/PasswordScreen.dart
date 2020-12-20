import 'dart:convert';
import 'dart:io';

import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:DesiMartProto/screens/Buyer/HomeScreen.dart';
import 'package:DesiMartProto/screens/LogReg/LoadingScreen.dart';
import 'package:DesiMartProto/screens/LogReg/NewPasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PasswordScreen extends StatefulWidget {
  final String email;
  PasswordScreen(this.email);
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _loaded;
  Buyer buyer;

  void initState() {
    super.initState();
    _loaded = false;
    buyer = Buyer();
    checkUserExists();
  }

  // Server connection code here
  Future<void> checkUserExists() async {
    String url = "https://desimart.herokuapp.com/getuserdetails";
    Map map = {'email': widget.email};
    String body = json.encode(map);
    try {
      http.Response response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          // ignore: missing_return
          .timeout(Duration(minutes: 1), onTimeout: () async {
        Fluttertoast.showToast(msg: 'Connection Timed Out..');
        Navigator.of(context).pop();
      });
      if (response.statusCode == 420) {
        print(response);
        Map<String, dynamic> result = json.decode(response.body);
        buyer.id = result['userid'];
        buyer.name = result['name'];
        buyer.email = result['email'];
        buyer.phone = result['mobileNumber'];
        buyer.password = result['password'];
        buyer.location = result['location'];
        buyer.city = result['city'];
        buyer.pinCode = result['pinCode'];
        print(buyer.location);
        setState(() {
          _loaded = true;
        });
      } else {
        Fluttertoast.showToast(msg: "This email id is not resgistered yet...");
        Navigator.pop(context);
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
      Navigator.of(context).pop();
    }
  }

  // UI starts here
  @override
  Widget build(BuildContext context) {
    return (!_loaded)
        ? LoadingScreen()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/shopping2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45.0, vertical: 20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                        onFieldSubmitted: (value) {
                          if (value == buyer.password) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                                (route) => false);
                          } else {
                            Fluttertoast.showToast(msg: "Incorrect Password");
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NewPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
