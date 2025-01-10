import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/datasource/auth_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/login_request_model.dart';
import 'package:flutter_ecatalog/data/models/response/login_response_model.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource datasource;
  LoginBloc(this.datasource) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      // TODO: implement event handler
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold((error) => emit(LoginError(message: error)),
          (data) => emit(LoginSuccess(model: data)));
    });
  }
}
