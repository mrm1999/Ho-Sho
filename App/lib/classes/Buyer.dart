import 'dart:html';

import 'Transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Buyer {
  String id;
  String name;
  String phone;
  String email;
  String password;
  List<Transaction> transactions;
  bool isSeller;
  String location;
  String city;
  String pinCode;

  static Buyer buyer;
  Buyer._internal();

  factory Buyer() {
    if (buyer == null) {
      buyer = Buyer._internal();
    }
    return buyer;
  }

  Future modifyBuyer(String name, String phone, String email, String location,
      String city, String pinCode) async {
    var payload = {
      "email": email,
      "name": name,
      "mobileNumber": phone,
      "location": location,
      "pinCode": pinCode,
      "city": city
    };
    http.Response resp = await http
        .post("http://hoshoo.herokuapp.com/updateuser", body: payload);
    Map<String, dynamic> result = json.decode(resp.body);

    if (resp.statusCode == 200) {
      buyer.name = name;
      buyer.phone = phone;
      buyer.email = email;
      buyer.location = location;
      buyer.city = city;
      buyer.pinCode = pinCode;
    }
  }

  Future fetchUserfromEmail() async {
    http.Response resp = await http.post(
        "http://hoshoo.herokuapp.com/getuserbyemail",
        body: {"email": email});
    Map<String, dynamic> result = json.decode(resp.body);

    buyer.id = result["user_id"];
    buyer.name = result["name"];
    buyer.email = result["email"];
    buyer.password = result["password"];
    buyer.phone = result["mobileNumber"];
    buyer.isSeller = (result["isSeller"] == 'y') ? true : false;
    buyer.location = result["location"];
    buyer.pinCode = result["pincode"];
    buyer.city = result["city"];
  }

  Future<String> getUserfromEmail(email) async {
    http.Response resp = await http
        .post("http://hoshoo.herokuapp.com/getuserid", body: {"email": email});
    Map<String, dynamic> result = json.decode(resp.body);
    return result["user_id"];
  }

  void makeSeller() {
    buyer.isSeller = true;
  }

  Future<bool> payfromto(String buyer_id, String seller_id, int amount) async {
    http.Response response =
        await http.post("http://hoshoo.herokuapp.com/payfromto", body: {
      "buyer_id": buyer_id,
      "seller": buyer_id,
      "amount": amount,
    });
    Map<String, dynamic> result = json.decode(response.body);
    return (result['success'] == 'y');
  }

  Future<int> getAccountBal() async {
    http.Response response = await http.post(
        "http://hoshoo.herokuapp.com/getbal",
        body: {"user_id": buyer.id});
    Map<String, dynamic> result = json.decode(response.body);

    if(result['balance'] == null) return 0;
    else return result['balance'];
  }

  Future<bool> recordTransac(/*send cart in here*/) async {
    http.Response response = await http.post(
        "http://hoshoo.herokuapp.com/getbal",
        body: {"user_id": buyer.id});
    
    if(response.statusCode == 200) return true;
    else return false;
  }
}
