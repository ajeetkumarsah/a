part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchSubscriptionEvent extends MyProfileEvent {
  final String type;

  FetchSubscriptionEvent({required this.type});
  @override
  // TODO: implement props
  List<Object> get props => [this.type];
}

class FetchedSubscriptionEvent extends MyProfileEvent {
  final List<SubscriptionModel> subscription;

  FetchedSubscriptionEvent({required this.subscription});
  @override
  // TODO: implement props
  List<Object> get props => [this.subscription];
}
