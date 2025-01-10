import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

import '../../data/models/request/product_request_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc() : super(UpdateProductInitial()) {
    on<UpdateProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
