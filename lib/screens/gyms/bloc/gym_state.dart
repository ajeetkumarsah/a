part of 'gym_bloc.dart';

@immutable
abstract class GymState {}

class GymInitial extends GymState {

}
class FetchGymListState extends GymState{
  final List<GymListModel> gymList;

  FetchGymListState({required this.gymList});

}