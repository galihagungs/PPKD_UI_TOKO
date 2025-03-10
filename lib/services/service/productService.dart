import 'package:ui_store/models/productModel.dart';
import 'package:ui_store/services/api/product.dart';

class Productservice {
  final String url;
  Productservice(this.url);

  final _api = ProductApi();
  Future<ProductModel> getData(url) async {
    return _api.getProductbyUrl(url);
  }
}
