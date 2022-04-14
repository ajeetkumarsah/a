part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class FetchProfileState extends ProfileState {
  final String id;

  FetchProfileState({required this.id});
  @override
  List<Object> get props => [this.id];
}

class FetchUserInfoState extends ProfileState {
  final UserProfile userInfo;

  FetchUserInfoState({required this.userInfo});
  @override
  List<Object> get props => [this.userInfo];
}
