import 'package:DesiMartProto/classes/Comment.dart';

class Item {
  String name;
  String shopName;
  String description;
  String photoURL;
  double price;
  double rating = 3;
  List<Comment> comments;
  String productId;

  Item(this.name, this.shopName, this.description, this.photoURL, this.price, this.productId);
}
