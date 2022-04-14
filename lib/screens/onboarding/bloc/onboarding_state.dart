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

class PostOnboardingState extends OnboardingState {
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

class FetchType1State extends OnboardingState {
  final String type;
  FetchType1State({required this.type});
  @override
  List<Object> get props => [this.type];
}

class FetchType2State extends OnboardingState {
  final String type;
  FetchType2State({required this.type});
  @override
  List<Object> get props => [this.type];
}

class FetchedType1State extends OnboardingState {
  final List<Type1Type2Model> type1type2model;
  FetchedType1State({required this.type1type2model});
  @override
  List<Object> get props => [this.type1type2model];
}

class FetchedType2State extends OnboardingState {
  final List<Type1Type2Model> type1type2model;
  FetchedType2State({required this.type1type2model});
  @override
  List<Object> get props => [this.type1type2model];
}
