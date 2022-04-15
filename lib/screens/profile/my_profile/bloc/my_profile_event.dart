part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchSubscriptionEvent extends MyProfileEvent {
  final dynamic subscription;

  FetchSubscriptionEvent({required this.subscription});
  @override
  // TODO: implement props
  List<Object> get props => [this.subscription];
}
