part of 'gym_bloc.dart';

@immutable
abstract class GymEvent {

}
class FetchGymsEvent extends GymEvent{
final String userId;

  FetchGymsEvent({required this.userId});
}


class FetchGymListEvent extends GymEvent{
  final List<GymListModel> gymList;

  FetchGymListEvent({required this.gymList});

}