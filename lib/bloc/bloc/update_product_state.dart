part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductSuccess extends UpdateProductState {
  final ProductResponseModel model;
//
  UpdateProductSuccess({required this.model});
}

final class UpdateProductError extends UpdateProductState {
  final String message;

  UpdateProductError({required this.message});
}
