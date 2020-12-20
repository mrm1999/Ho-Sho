import 'package:DesiMartProto/classes/Transaction.dart';
import 'Product.dart';
import 'package:http/http.dart' as http;

class Seller {
  String shopName;
  List<Product> products;
  List<Transaction> orders;

  // Remove this later
  String name;
  String email;

  Future<bool> rejectOrder(String transac_id) async {
    http.Response resp = await http.post(
        "http://hoshoo.herokuapp.com/rejectorder",
        body: {"transac_id": transac_id});

    if(resp.statusCode == 200) return true;
    else return false;
  }


}
