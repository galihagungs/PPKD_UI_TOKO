part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {
  const ProductEvent();
  List<Object> get props => [];
}

class ProductGetbyUrl extends ProductEvent {
  final String url;
  const ProductGetbyUrl(this.url);
}
