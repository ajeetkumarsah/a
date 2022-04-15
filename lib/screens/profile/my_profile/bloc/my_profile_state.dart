part of 'my_profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class FetchSubscriptionState extends MyProfileState {
  final String type;

  FetchSubscriptionState({required this.type});
  @override
  // TODO: implement props
  List<Object> get props => [this.type];
}

class FetchedSubscriptionState extends MyProfileState {
  final List<SubscriptionModel> subscription;

  FetchedSubscriptionState({required this.subscription});
  @override
  // TODO: implement props
  List<Object> get props => [this.subscription];
}
