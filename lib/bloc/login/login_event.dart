part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final LoginRequestModel model;

  DoLoginEvent({required this.model});
}
