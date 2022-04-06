part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class OnLoginState extends LoginState {
  bool phoneAuth;
  final String firstData;
  final String authenticator;

  OnLoginState(
      {required this.firstData,
      required this.authenticator,
      this.phoneAuth = true});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.phoneAuth, this.authenticator, this.firstData];
}

class LoginStatusState extends LoginState {
  final LoginResponse loginDetails;
  final bool isSuccess;
  final String msg;

  LoginStatusState(
      {required this.loginDetails, required this.isSuccess, required this.msg});
  @override
  // TODO: implement props
  List<Object?> get props => [this.loginDetails, this.isSuccess, this.msg];
}
