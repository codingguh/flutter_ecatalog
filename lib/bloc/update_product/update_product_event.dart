part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductEvent {}

class DoUpdateProductEvent extends UpdateProductEvent {
  final ProductRequestModel model;
  final int id;
  DoUpdateProductEvent({
    required this.model,
    required this.id,
  });
}
