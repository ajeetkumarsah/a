part of 'gym_details_bloc.dart';

@immutable
abstract class GymDetailsState {}

class GymDetailsInitial extends GymDetailsState {}

class FetchGymDetailsState extends GymDetailsState {
  final GymDetailsModel gymDetails;

  FetchGymDetailsState({required this.gymDetails});
}

class FetchMembershipPlanState extends GymDetailsState {
  final List<MembershipPlan> membershipPlan;

  FetchMembershipPlanState({required this.membershipPlan});
}

class FetchOfferState extends GymDetailsState {
  final List<OffersModel> offers;

  FetchOfferState({required this.offers});
}
