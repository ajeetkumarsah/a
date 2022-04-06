part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  @override
  List<Object> get props => [];
}

class FetchOnboardingState extends OnboardingState {
  final String id;

  FetchOnboardingState({required this.id});

  @override
  List<Object> get props => [this.id];
}

class PostOnboardingState extends OnboardingEvent {
  final AddMembershipModel memberShip;

  PostOnboardingState({required this.memberShip});

  @override
  List<Object> get props => [this.memberShip];
}

class OnboardingStatusState extends OnboardingState {
  final AddMembershipModel onboardingResponse;
  final bool isSuccess;
  final String msg;

  OnboardingStatusState(
      {required this.onboardingResponse,
      required this.isSuccess,
      required this.msg});
  @override
  List<Object> get props => [this.onboardingResponse, this.isSuccess, this.msg];
}
