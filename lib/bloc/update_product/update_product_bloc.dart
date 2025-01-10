import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/datasource/product_datasource.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

import '../../data/models/request/product_request_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDataSource dataSource;

  UpdateProductBloc(this.dataSource) : super(UpdateProductInitial()) {
    on<DoUpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result = await dataSource.updateProduct(event.model, event.id);

      result.fold(
        (error) => emit(UpdateProductError(message: error)),
        (data) => emit(UpdateProductSuccess(model: data)),
      );
    });
  }
}
