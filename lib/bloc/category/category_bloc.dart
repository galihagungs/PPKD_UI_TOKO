import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_store/localdb/dbHelper.dart';
import 'package:ui_store/localdb/query/categoryLocalQuery.dart';
import 'package:ui_store/services/api/category.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  Dbhelper dbhelper = Dbhelper();
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryGet) {
        try {
          emit(CategoryLoading());
          final data = await CategoryApi().getCategory();
          for (var item in data) {
            await dbhelper.insertCategory(
              titleData: CategoryQuery.tableName,
              data: {
                CategoryQuery.slug: item.slug,
                CategoryQuery.name: item.name,
                CategoryQuery.url: item.url,
              },
            );
          }
          final data2 = await dbhelper.getCategory();
          emit(CategorySucces(data2));
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
    });
  }
}
