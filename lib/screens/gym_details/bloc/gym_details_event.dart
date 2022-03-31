part of 'gym_details_bloc.dart';

@immutable
abstract class GymDetailsEvent {}

class FetchGymDetailsEvent extends GymDetailsEvent {
  final String uid;

  FetchGymDetailsEvent({required this.uid});
}

class FetchGymDetailsDataEvent extends GymDetailsEvent {
  final GymDetailsModel gymDetails;

  FetchGymDetailsDataEvent({required this.gymDetails});
}

class FetchGymPlanEvent extends GymDetailsEvent {
  final String id;

  FetchGymPlanEvent({required this.id});
}

class FetchMembershipPlanEvent extends GymDetailsEvent {
  final List<MembershipPlan> membershipPlan;

  FetchMembershipPlanEvent({required this.membershipPlan});
}

class FetchOffersEvent extends GymDetailsEvent {
  final String id;

  FetchOffersEvent({required this.id});
}

class FetchOfferListEvent extends GymDetailsEvent {
  final List<OffersModel> offers;

  FetchOfferListEvent({required this.offers});
}
