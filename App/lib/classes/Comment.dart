// import 'Buyer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comment {
  //Buyer buyer;
  String buyer;
  // String titile;
  String description;
  int ratingGiven;

  Comment(this.buyer, this.description, this.ratingGiven);

  // static Comment fromJson(Map<String, dynamic> json) {
  //   return Comment(name, json["description"], json["rating"]);
  // }

  // static Future<List<Comment>> getComments(String prodId) async {
  //   http.Response resp = await http
  //       .post("http://127.0.0.1/getallcomments", body: {"product_id": prodId});
  //   var normList = json.decode(resp.body) as List;
  //   var commentList = normList.map((e) => Comment.fromJson(e));
  //   return commentList;
  // }

  static Future postComment(
      String uid, String prodId, String description, int rating) async {
    http.Response resp =
        await http.post("http://127.0.0.1/getallcomments", body: {
      "user_id": uid,
      "product_id": prodId,
      "comment": description,
    });
    Map<String, dynamic> result = json.decode(resp.body);
    return result.containsKey("success");
  }
}
