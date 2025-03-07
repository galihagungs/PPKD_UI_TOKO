part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {
  const CategoryEvent();

  List<Object> get props => [];
}

class CategoryGet extends CategoryEvent {}
