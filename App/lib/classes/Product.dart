import 'Comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  String productId;
  String productName;
  String seller_id;
  String shopName;
  String photoURL;
  String desciption;
  String categ_id;
  double price;
  String measure;
  int hoursBefore;
  List<Comment> comments;
  double rating;
  int num_revs;

  Product(
      this.productId,
      this.productName,
      this.seller_id,
      this.shopName,
      this.photoURL,
      this.desciption,
      this.categ_id,
      this.price,
      this.measure,
      this.hoursBefore,
      this.rating,
      this.num_revs);

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      json["product_id"],
      json["product_name"],
      json["seller_id"],
      json["shop_name"],
      json['img_url'],
      json["desciption"],
      json["category_id"],
      json["price"],
      json["measure_unit"],
      json["hours_befo"],
      json["rating"],
      json["num_review"],
    );
  }

  Future<List<Product>> fetchByShop(String shopId) async {
    String url = "http://hoshoo.herokuapp.com/getprodbyshop";
    http.Response resp = await http.post(url, body: {"seller_id": shopId});
    var normList = json.decode(resp.body) as List;
    var prodList = normList.map((e) => Product.fromJson(e));
    return prodList;
  }

  Future<List<Product>> getLatest(String prodId) async {
    http.Response resp =
        await http.get("http://hoshoo.herokuapp.com/getlatestprods");
    var normList = json.decode(resp.body) as List;
    var prodList = normList.map((prod) => Product.fromJson(prod));
    return prodList;
  }

  Future<List<Product>> getByCat(String prodCat) async {
    http.Response resp = await http.post(
        "http://hoshoo.herokuapp.com/getprodbycat",
        body: {"category": prodCat});
    var normList = json.decode(resp.body) as List;
    var prodList = normList.map((prod) => Product.fromJson(prod));
    return prodList;
  }

  Future<List<Product>> getByName(String name) async {
    http.Response resp = await http.post(
        "http://hoshoo.herokuapp.com/getprodbyname",
        body: {"name": name});
    var normList = json.decode(resp.body) as List;
    var prodList = normList.map((prod) => Product.fromJson(prod));
    return prodList;
  }

  Future<List<Product>> updateProduct(String name) async {
    http.Response resp =
        await http.get("http://hoshoo.herokuapp.com/updateproduct");
    var normList = json.decode(resp.body) as List;
    var prodList = normList.map((prod) => Product.fromJson(prod));
    return prodList;
  }
}
