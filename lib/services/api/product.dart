import 'dart:convert';

import 'package:ui_store/localdb/dbHelper.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future<ProductModel> getProductbyUrl(String url) async {
    Dbhelper dbHelper = Dbhelper();
    var client = http.Client();
    var uri = Uri.parse(url);
    var res = await client.get(uri);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body)['products'];
      for (var item in data) {
        await dbHelper.insertProduct(
          titleData: 'Product',
          data: {'id': item['id'], 'title': item['title']},
        );
      }
      return ProductModel.fromJson(jsonDecode(res.body));
    }
    return ProductModel();
  }
}
