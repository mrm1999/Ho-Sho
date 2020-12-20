import 'dart:convert';
import 'dart:io';

import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class BuyerProfileScreen extends StatefulWidget {
  @override
  _BuyerProfileScreenState createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  TextEditingController _nameController,
      _emailController,
      _phoneController,
      _streetController,
      _cityController,
      _pinController;
  bool _change;
  GlobalKey _formKey;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: Buyer().name);
    _emailController = TextEditingController(text: Buyer().email);
    _phoneController = TextEditingController(text: Buyer().phone);
    _streetController = TextEditingController(text: Buyer().location);
    _cityController = TextEditingController(text: Buyer().city);
    _pinController = TextEditingController(text: Buyer().pinCode);
    _change = false;
    _formKey = GlobalKey<FormState>();
  }

  Future editUserProfile(String name, String email, String phone,
      String location, String city, String pinCode) async {
    String url = "https://desimart.herokuapp.com/updateuser";
    Map map = {
      'name': name,
      'email': email,
      'mobileNumber': phone,
      'location': location,
      'city': city,
      'pinCode': pinCode,
    };
    String body = json.encode(map);
    try {
      http.Response response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .timeout(Duration(seconds: 5), onTimeout: () {
        Fluttertoast.showToast(msg: 'Connection Timed Out..');
        Navigator.of(context).pop();
        return null;
      });
      if (response.statusCode == 200) {
        Buyer().modifyBuyer(name, phone, email, location, city, pinCode);
        Fluttertoast.showToast(msg: 'Profile updated Successfully..');
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'My Profile',
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
                      Icons.person,
                      color: Colors.grey,
                      size: 60.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setState(() {
                      _change = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  enabled: false,
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        _change = true;
                      });
                    },
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    labelText: 'Street Address',
                  ),
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) {
                    setState(() {
                      _change = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setState(() {
                      _change = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: TextFormField(
                  controller: _pinController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _change = true;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_change) {
                      editUserProfile(
                          _nameController.text,
                          _emailController.text,
                          _phoneController.text,
                          _streetController.text,
                          _cityController.text,
                          _pinController.text);
                    } else {
                      Fluttertoast.showToast(
                          msg: "No changes made to the profile");
                    }
                  },
                  color: Colors.lightBlue,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
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
