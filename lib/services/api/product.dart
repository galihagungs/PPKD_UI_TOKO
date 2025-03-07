import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future<List<ProductModel>> getProductbyUrl(String url) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var res = await client.get(uri);
    print(res.statusCode);
    if (res.statusCode == 200) {
      // var data = List<ProductModel>.from(jsonDecode(res.body)["products"]);
      print(res.body);
      return List<ProductModel>.from(
        jsonDecode(res.body)['products'].map((e) => ProductModel.fromJson(e)),
      );
    }
    return [];
  }
}
