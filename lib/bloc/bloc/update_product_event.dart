part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductEvent {
  final ProductRequestModel model;

  UpdateProductEvent({required this.model});
}
