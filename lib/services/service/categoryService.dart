import 'package:ui_store/models/categoryModel.dart';
import 'package:ui_store/services/api/category.dart';

class Categoryservice {
  final _api = CategoryApi();
  Future<List<CategoryModel>?> getData() async {
    return _api.getCategory();
  }
}
