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
  final BuildContext context;
  PostOnboardingEvent({required this.memberShip, required this.context});

  @override
  List<Object> get props => [this.memberShip, this.context];
}

class SignupSuccessEvent extends OnboardingEvent {
  final bool isSuccess;
  final String msg;
  SignupSuccessEvent({required this.isSuccess, required this.msg});
  @override
  List<Object> get props => [this.isSuccess, this.msg];
}

class FetchType1Event extends OnboardingEvent {
  final String type;
  FetchType1Event({required this.type});
  @override
  List<Object> get props => [this.type];
}

class FetchType2Event extends OnboardingEvent {
  final String type;
  FetchType2Event({required this.type});
  @override
  List<Object> get props => [this.type];
}

class FetchedType1Event extends OnboardingEvent {
  final List<Type1Type2Model> type1model;
  FetchedType1Event({required this.type1model});
  @override
  List<Object> get props => [this.type1model];
}

class FetchedType2Event extends OnboardingEvent {
  final List<Type1Type2Model> type2model;
  FetchedType2Event({required this.type2model});
  @override
  List<Object> get props => [this.type2model];
}
