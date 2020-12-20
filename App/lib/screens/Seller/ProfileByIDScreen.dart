import 'package:DesiMartProto/classes/Buyer.dart';
import 'package:flutter/material.dart';

class ProfileByIDScreen extends StatefulWidget {
  final String id;
  ProfileByIDScreen(this.id);
  @override
  _ProfileByIDScreenState createState() => _ProfileByIDScreenState();
}

class _ProfileByIDScreenState extends State<ProfileByIDScreen> {
  TextEditingController _nameController,
      _emailController,
      _phoneController,
      _streetController,
      _cityController,
      _pinController;
  GlobalKey _formKey;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: Buyer().name);
    _emailController = TextEditingController(text: Buyer().email);
    _phoneController = TextEditingController(text: Buyer().phone);
    _streetController = TextEditingController(text: Buyer().location);
    _cityController = TextEditingController(text: Buyer().city);
    _pinController = TextEditingController(text: Buyer().pinCode);
    _formKey = GlobalKey<FormState>();
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
                        enabled: false,
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
                          enabled: false,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                      child: TextFormField(
                        controller: _streetController,
                        decoration: InputDecoration(
                          labelText: 'Street Address',
                        ),
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'City',
                        ),
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                      child: TextFormField(
                        controller: _pinController,
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                        ),
                        enabled: false,
                      ),
                    ),
                  ]
              ),
          ),
        ),
    );
  }
}
