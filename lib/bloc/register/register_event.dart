part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequestModel model;

  DoRegisterEvent({required this.model});
}
