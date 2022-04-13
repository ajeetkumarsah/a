part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  List<Object?> get props => [];
}

class FetchSignupEvent extends SignupEvent {
  final String id;

  FetchSignupEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class SendOTPEvent extends SignupEvent {
  final String mobile;

  SendOTPEvent({required this.mobile});

  @override
  List<Object?> get props => [];
}

class FetchOtpEvent extends SignupEvent {
  final String otp;

  FetchOtpEvent({required this.otp});
  @override
  List<Object?> get props => [this.otp];
}

class PostSignupEvent extends SignupEvent {
  final SignupModel signupDetails;

  PostSignupEvent({required this.signupDetails});

  @override
  List<Object?> get props => [];
}

class SignupSuccessEvent extends SignupEvent {
  final bool isSuccess;
  final String msg;
  SignupSuccessEvent({required this.isSuccess, required this.msg});

  @override
  List<Object?> get props => [this.isSuccess, this.msg];
}

class SignupStatusEvent extends SignupEvent {
  final SignupResponse signupResponse;
  final bool isSuccess;
  final String msg;

  SignupStatusEvent(
      {required this.signupResponse,
      required this.isSuccess,
      required this.msg});
  @override
  List<Object?> get props => [this.signupResponse, this.isSuccess, this.msg];
}
