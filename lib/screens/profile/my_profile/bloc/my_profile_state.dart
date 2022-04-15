part of 'my_profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();
  
  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}
