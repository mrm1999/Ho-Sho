import 'Item.dart';
import 'Product.dart';

class Transaction {
  int transactionID;
  double amount;
  String buyerID;
  String shopID;
  int orderStatus;
  //List<Product> products;
  List<Item> items;
  List<int> quantity;
  bool delivery;

  Transaction(this.amount, this.items, this.quantity);
}
