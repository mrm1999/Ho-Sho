import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'EmailScreen.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController _pwdController, _cnfController;
  GlobalKey _formKey;

  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _pwdController = TextEditingController();
    _cnfController = TextEditingController();
  }

  Future changePassword(String value) async {
    String url = "https://desimart.herokuapp.com/changePwd";
    Map map = {
      'pwd': value,
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
      if (response != null) {
        print(response);
        Map<String, dynamic> resmap = json.decode(response.body);
        bool result = resmap['uid'];
        print(result);
        if (result) {
          setState(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => EmailScreen()),
                (route) => false);
            Fluttertoast.showToast(msg: 'You can login now...');
          });
        } else {
          Fluttertoast.showToast(msg: 'User is not registered...');
          Navigator.of(context).pop();
        }
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/shopping2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _pwdController,
                    validator: (value) {
                      if (value.isEmpty) return "This field cannot be empty";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Create New Password',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _cnfController,
                    validator: (value) {
                      if (_cnfController.text != _pwdController.text)
                        return "Doesn't match with password";
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                ),
                RaisedButton(
                  onPressed: () => changePassword(_cnfController.text),
                  child: Text('CONFIRM'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
