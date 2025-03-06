import 'dart:convert';

import 'package:ui_store/models/categoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<List<CategoryModel>> getCategory() async {
    var client = http.Client();
    var uri = Uri.parse("https://dummyjson.com/products/categories");
    var res = await client.get(uri);
    if (res.statusCode == 200) {
      return List<CategoryModel>.from(
        jsonDecode(res.body).map((cat) => CategoryModel.fromJson(cat)),
      );
    }
    return [];
  }
}
