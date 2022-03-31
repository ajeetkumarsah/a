part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class FetchGymDetailsState extends LoginState {
  final LoginModel logInDetails;

  FetchGymDetailsState({required this.logInDetails});
}
