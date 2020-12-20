import 'package:DesiMartProto/screens/LogReg/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formKey;
  TextEditingController _nameController,
      _emailController,
      _numberController,
      _pwdController,
      _locController,
      _cityController,
      _pinController;

  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _pwdController = TextEditingController();
    _numberController = TextEditingController();
    _locController = TextEditingController();
    _cityController = TextEditingController();
    _pinController = TextEditingController();
  }

  bool isValidEmail(String string) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(string);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 45.0, right: 45.0, top: 100.0, bottom: 5.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value.isEmpty) return "This field cannot be empty";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "This field cannot be empty";
                        else if (!isValidEmail(value))
                          return "Not a valid email";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: IntlPhoneField(
                        controller: _numberController,
                        validator: (value) {
                          if (value.isEmpty)
                            return "This field cannot be empty";
                          else if (value.length != 10)
                            return "Not a valid number";
                          return null;
                        },
                        autoValidate: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                        initialCountryCode: 'IN',
                        keyboardType: TextInputType.phone,
                        onSubmitted: (String value) {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _pwdController,
                      validator: (value) {
                        if (value.isEmpty) return "This field cannot be empty";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      onEditingComplete: () => node.nextFocus(),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _locController,
                      validator: (value) {
                        if (value.isEmpty) return "This field cannot be empty";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter Address location',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _cityController,
                      validator: (value) {
                        if (value.isEmpty) return "This field cannot be empty";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter City',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 5.0),
                    child: TextFormField(
                      controller: _pinController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "This field cannot be empty";
                        else if (value.length != 6) return "Invalid Pincode";
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter pincode',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      keyboardType: TextInputType.number,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RaisedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OTPScreen(
                                  _nameController.text,
                                  _emailController.text,
                                  _numberController.text,
                                  _pwdController.text,
                                  _locController.text,
                                  _cityController.text,
                                  _pinController.text))),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
