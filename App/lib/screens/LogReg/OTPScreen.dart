import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:DesiMartProto/screens/LogReg/EmailScreen.dart';
import 'package:DesiMartProto/screens/LogReg/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  final String name, email, phone, pwd, loc, city, pin;
  OTPScreen(this.name, this.email, this.phone, this.pwd, this.loc, this.city,
      this.pin);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Timer _timer;
  int _start;
  bool _loaded;
  String otp;

  void initState() {
    super.initState();
    _loaded = false;
    sendOTPtoUser();
  }

  Future<void> sendOTPtoUser() async {
    String url = "http://desimart.herokuapp.com/checkemailid";
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
      if (response.statusCode == 200) {
        print(response);
        print("Body : " + response.body);
        Map<String, dynamic> result = json.decode(response.body);
        print(result);
        otp = result['otp'];
        print(otp);
        setState(() {
          _loaded = true;
          _start = 300;
          startTimer();
        });
      } else if (response.statusCode == 105) {
        Fluttertoast.showToast(msg: 'Email Id already registered..');
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: 'There was some error registering the user');
        Navigator.of(context).pop();
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
      Navigator.of(context).pop();
    }
  }

  Future<void> registerUser() async {
    String url = "http://desimart.herokuapp.com/user_registration";
    Map map = {
      'name': widget.name,
      'email': widget.email,
      'mobieNumber': widget.phone,
      'password': widget.pwd,
      'location': widget.loc,
      'city': widget.city,
      'pinCode': widget.pin
    };
    String body = json.encode(map);
    try {
      http.Response response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          // ignore: missing_return
          .timeout(Duration(minutes: 1), onTimeout: () async {
        Fluttertoast.showToast(msg: 'Connection Timed Out..');
        Navigator.of(context).pop();
      });
      if (response.statusCode == 205) {
        print(response);
        setState(() {
          Fluttertoast.showToast(
              msg: "You can Login now.. Registration Successful..");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => EmailScreen()),
              (route) => false);
        });
      } else {
        Fluttertoast.showToast(msg: "Cannot Register... There was some error");
        Navigator.pop(context);
      }
    } on SocketException {
      Fluttertoast.showToast(msg: 'Please check your internet connection..');
      Navigator.of(context).pop();
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Fluttertoast.showToast(msg: "OTP Expired.. Please try again...");
            Navigator.of(context).pop();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // UI starts from here
  @override
  Widget build(BuildContext context) {
    return !_loaded
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
                      child: PinEntryTextField(
                        fields: 4,
                        showFieldAsBox: true,
                        onSubmit: (String pin) {
                          if (pin != otp)
                            return "INVALID OTP";
                          else
                            registerUser();
                        },
                      ),
                    ),
                    Text('Confirm before ' + _start.toString()),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _loaded = false;
                          sendOTPtoUser();
                        });
                      },
                      child: Text(
                        'Resend OTP ?',
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
