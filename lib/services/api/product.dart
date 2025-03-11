import 'dart:convert';

import 'package:ui_store/localdb/dbHelper.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future<ProductModel> getProductbyUrl() async {
    // Dbhelper dbHelper = Dbhelper();
    var client = http.Client();
    // var uri = Uri.parse(url);
    var uri = Uri.parse("https://dummyjson.com/products/");
    var res = await client.get(uri);

    if (res.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(res.body));
    }
    return ProductModel();
  }
}
