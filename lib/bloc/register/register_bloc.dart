import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/datasource/auth_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/register_request_model.dart';
import 'package:flutter_ecatalog/data/models/response/register_response_model.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(this.datasource) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      //kirim register request model-> datasource emnunggu response
      final result = await datasource.register(event.model);
      result.fold((error) {
        emit(RegisterError(message: error));
      }, (data) {
        emit(RegisterSuccess(model: data));
      });
      // emit(RegisterSuccess());
    });
  }
}
