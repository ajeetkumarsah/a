part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class FetchLogInEvent extends LoginEvent {
  final String id;

  FetchLogInEvent({required this.id});
}

class PostLogInEvent extends LoginEvent {
  final LoginModel loginDetails;

  PostLogInEvent({required this.loginDetails});
}

class FetchLoginEvent extends LoginEvent {
  final LoginResponse loginResponse;

  FetchLoginEvent({required this.loginResponse});
}
