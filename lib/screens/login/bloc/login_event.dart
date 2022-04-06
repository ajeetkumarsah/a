part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoginEvent extends LoginEvent {
  bool phoneAuth;
  final String firstData;
  final String authenticator;

  OnLoginEvent(
      {required this.firstData,
      required this.authenticator,
      this.phoneAuth = true});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.phoneAuth, this.authenticator, this.firstData];
}

class LoginStatusEvent extends LoginEvent {
  final LoginResponse loginDetails;
  final bool isSuccess;
  final String msg;

  LoginStatusEvent(
      {required this.loginDetails, required this.isSuccess, required this.msg});
  @override
  // TODO: implement props
  List<Object?> get props => [this.loginDetails, this.isSuccess, this.msg];
}
