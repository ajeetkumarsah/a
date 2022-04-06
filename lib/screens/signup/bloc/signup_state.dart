part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable {
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {
  List<Object?> get props => [];
}

class FetchSignupState extends SignupState {
  final String id;

  FetchSignupState({required this.id});

  @override
  List<Object?> get props => [];
}

class SendOTPState extends SignupState {
  final String mobile;

  SendOTPState({required this.mobile});

  @override
  List<Object?> get props => [];
}

class FetchOtpState extends SignupState {
  final String otp;

  FetchOtpState(this.otp);
  @override
  // TODO: implement props
  List<Object?> get props => [this.otp];
}

class SignupSuccessState extends SignupState {
  final bool isSuccess;
  final String msg;
  SignupSuccessState({required this.isSuccess, required this.msg});

  @override
  List<Object?> get props => [this.isSuccess, this.msg];
}

class SignupStatusState extends SignupState {
  final SignupResponse signupResponse;
  final bool isSuccess;
  final String msg;

  SignupStatusState(
      {required this.signupResponse,
      required this.isSuccess,
      required this.msg});
  @override
  List<Object?> get props => [this.signupResponse, this.isSuccess, this.msg];
}
