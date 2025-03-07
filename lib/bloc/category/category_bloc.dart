import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_store/services/api/category.dart';

import '../../models/categoryModel.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryGet) {
        try {
          emit(CategoryLoading());
          final data = await CategoryApi().getCategory();
          emit(CategorySucces(data));
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
    });
  }
}
