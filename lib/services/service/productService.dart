import 'package:ui_store/models/productModel.dart';
import 'package:ui_store/services/api/product.dart';

class Productservice {
  Productservice();

  final _api = ProductApi();
  Future<ProductModel> getData() async {
    return _api.getProductbyUrl();
  }
}
