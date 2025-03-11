import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_store/localdb/dbHelper.dart';
import 'package:ui_store/localdb/query/productLocalQuery.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:ui_store/services/api/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Dbhelper dbhelper = Dbhelper();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProductAll) {
        try {
          emit(ProductLoading());
          final data = await ProductApi().getProductbyUrl();
          if (data.products != null) {
            for (var item in data.products!) {
              await dbhelper.insertProduct(
                titleData: ProductQuery.tableName,
                data: {
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'category': item.category,
                  'price': item.price,
                },
              );
            }
          }

          emit(ProductSucces([]));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      } else if (event is ProductGetbyCat) {
        try {
          emit(ProductLoading());

          final data2 = await dbhelper.getTaskByCategory(event.catName);
          emit(ProductSucces(data2));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      }
    });
  }
}

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc() : super(ProductInitial()) {
//     on<ProductEvent>((event, emit) async {
//       if (event is ProductGetbyUrl) {
//         try {
//           emit(ProductLoading());
//           print("Bloc url Check ${event.url}");
//           final data = await ProductApi().getProductbyUrl(event.url);
//           emit(ProductSucces(data));
//         } catch (e) {
//           emit(ProductFailed(e.toString()));
//         }
//       }
//     });
//   }
// }
