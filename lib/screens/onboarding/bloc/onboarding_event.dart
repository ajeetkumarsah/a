part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class FetchOnboardingEvent extends OnboardingEvent {
  final String id;

  FetchOnboardingEvent({required this.id});

  @override
  List<Object> get props => [this.id];
}

class PostOnboardingEvent extends OnboardingEvent {
  final AddMembershipModel memberShip;

  PostOnboardingEvent({required this.memberShip});

  @override
  List<Object> get props => [this.memberShip];
}

class SignupSuccessEvent extends OnboardingEvent {
  final bool isSuccess;
  final String msg;
  SignupSuccessEvent({required this.isSuccess, required this.msg});
  @override
  List<Object> get props => [this.isSuccess, this.msg];
}
