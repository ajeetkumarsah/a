import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/gym_details.dart';
import 'package:wtf_web/model/membership_plan.dart';
import 'package:wtf_web/model/offers.dart';
part 'gym_details_event.dart';
part 'gym_details_state.dart';

class GymDetailsBloc extends Bloc<GymDetailsEvent, GymDetailsState> {
  final _repository = Repository();

  GymDetailsBloc() : super(GymDetailsInitial()) {
    on<GymDetailsEvent>((event, emit) {
      if (event is FetchGymDetailsEvent) {
        emit(GymDetailsInitial());

        _repository
            .getGymDetails(uid: event.uid)
            .then((value) => _convertGymDetails(apiResponse: value));
      }
      if (event is FetchGymPlanEvent) {
        _repository
            .getMembershipPlan(id: event.id)
            .then((value) => _membershipPlanConvert(apiResponse: value));
      }

      if (event is FetchOffersEvent) {
        _repository
            .getOffers(id: event.id)
            .then((value) => _offersConvert(apiResponse: value));
      }
      if (event is FetchOfferListEvent) {
        emit(FetchOfferState(offers: event.offers));
      }
      if (event is FetchMembershipPlanEvent) {
        emit(FetchMembershipPlanState(membershipPlan: event.membershipPlan));
      }
      if (event is FetchGymDetailsDataEvent) {
        emit(FetchGymDetailsState(gymDetails: event.gymDetails));
      }
    });
  }
  void _convertGymDetails({required ApiResponse apiResponse}) {
    GymDetailsModel _gymDetails =
        GymDetailsModel.fromJson(apiResponse.finalData['data']);

    add(FetchGymDetailsDataEvent(gymDetails: _gymDetails));
  }

  void _membershipPlanConvert({required ApiResponse apiResponse}) {
    final parsed = apiResponse.finalData["data"] as List<dynamic>;
    List<MembershipPlan> _memberships =
        parsed.map((status) => MembershipPlan.fromJson(status)).toList();

    add(FetchMembershipPlanEvent(membershipPlan: _memberships));
  }

  void _offersConvert({required ApiResponse apiResponse}) {
    final parsed = apiResponse.finalData["data"] as List<dynamic>;
    List<OffersModel> _offers =
        parsed.map((status) => OffersModel.fromJson(status)).toList();

    add(FetchOfferListEvent(offers: _offers));
  }
}
