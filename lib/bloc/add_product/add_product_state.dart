part of 'add_product_bloc.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final ProductResponseModel model;
//
  AddProductSuccess({required this.model});
}

final class AddProductError extends AddProductState {
  final String message;

  AddProductError({required this.message});
}
