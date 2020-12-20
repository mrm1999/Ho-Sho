import 'package:DesiMartProto/screens/LogReg/EmailScreen.dart';
// import 'package:DesiMartProto/screens/LogReg/NewPasswordScreen.dart';
// import 'package:DesiMartProto/screens/LogReg/OTPScreen.dart';
// import 'package:DesiMartProto/screens/LogReg/PasswordScreen.dart';
// import 'package:DesiMartProto/screens/LogReg/RegistrationScreen.dart';
import 'package:flutter/material.dart';
// import 'screens/AppInner/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa', primaryColor: Colors.redAccent),
      themeMode: ThemeMode.light,
      title: 'DesiMart',
      home: EmailScreen(),
      //home: HomeScreen(),
    );
  }
}
