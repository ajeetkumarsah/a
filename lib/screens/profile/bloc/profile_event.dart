part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  FetchProfileEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchUserInfoEvent extends ProfileEvent {
  final UserProfile userInfo;

  FetchUserInfoEvent({required this.userInfo});
  @override
  // TODO: implement props
  List<Object> get props => [this.userInfo];
}
