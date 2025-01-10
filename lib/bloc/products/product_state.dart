part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductResponseModel> data;
//
  ProductSuccess({required this.data});
}

final class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
