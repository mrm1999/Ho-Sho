import 'dart:convert';
import 'dart:io';

import 'package:DesiMartProto/screens/LogReg/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'SellerHomeScreen.dart';

class InterSellerHome extends StatefulWidget {
  final String shopName;
  InterSellerHome(this.shopName);
  @override
  _InterSellerHomeState createState() => _InterSellerHomeState();
}

class _InterSellerHomeState extends State<InterSellerHome> {
  void initState() {
    super.initState();
    registerShop();
  }

  Future registerShop() async {
    String url = "https://desimart.herokuapp.com/registerShop";
    Map map = {'shopName': widget.shopName};
    String body = json.encode(map);
    try {
      http.Response response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .timeout(Duration(minutes: 1), onTimeout: () {
        Fluttertoast.showToast(msg: 'Connection Timed Out..');
        Navigator.of(context).pop();
        return null;
      });
      print(response);
      Map<String, dynamic> resmap = json.decode(response.body);
      bool result = resmap['uid'];
      print(result);
      if (result) {
        setState(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SellerHomeScreen()),
              (route) => false);
        });
      } else {
        Fluttertoast.showToast(msg: 'User is not registered...');
        Navigator.of(context).pop();
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
      Navigator.of(context).pop();
    }
  }
  
    
  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}

