part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseModel model;
//
  LoginSuccess({required this.model});
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
