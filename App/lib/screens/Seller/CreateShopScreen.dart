import 'package:flutter/material.dart';

import 'InterSellerHome.dart';

class CreateShopScreen extends StatefulWidget {
  @override
  _CreateShopScreenState createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {
  Future registerShop(String value) async {}

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 45.0, vertical: 20.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String value) {
                    if (value.isEmpty) return "Please Enter Something";
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Give some name to your shop',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  onFieldSubmitted: (value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => InterSellerHome(value)));
                  },
                  keyboardType: TextInputType.name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
