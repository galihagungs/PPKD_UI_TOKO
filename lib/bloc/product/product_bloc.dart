import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_store/localdb/dbHelper.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:ui_store/services/api/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductGetbyUrl) {
        try {
          emit(ProductLoading());
          final data = await ProductApi().getProductbyUrl(event.url);
          emit(ProductSucces(data));
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
