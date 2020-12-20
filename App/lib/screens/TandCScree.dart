import 'package:flutter/material.dart';

class TandCScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '1. This application is the project developed as a part of hackathon Hack with CW and the developers in no means are responsible for the misuse of application.\n\n' + 
              '2. If food items in any case cause health related issues to the consumers then the developer of the app will not be responsible',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
