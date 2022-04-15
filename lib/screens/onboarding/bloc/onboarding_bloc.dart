import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/type1_type2.dart';
import 'package:wtf_web/screens/widgets/alert_flash.dart';
import 'package:wtf_web/session_manager/global_data.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final _repository = Repository();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is PostOnboardingEvent) {
        if (globalData.memberInfo != null) {
          // print('UPDATE MEMBER FUNCTION CALLED========>');
          _repository.updateNewMember(memberShip: event.memberShip).then(
              (value) =>
                  _convertData(apiResponse: value, context: event.context));
        } else
          // print('ADD MEMBER FUNCTION CALLED========>');
          _repository.postNewMember(memberShip: event.memberShip).then(
              (value) =>
                  _convertData(apiResponse: value, context: event.context));
      }
      if (event is FetchType1Event) {
        // print('Api call FetchType1Event ============>');
        _repository
            .postType1Type2(type: event.type)
            .then((value) => _convertType1(apiResponse: value));
      }
      // if (event is FetchType2Event) {
      //   print('Api call FetchType2Event============>');
      //   _repository
      //       .postType1Type2(type: event.type)
      //       .then((value) => _convertType2(apiResponse: value));
      // }

      if (event is FetchedType1Event) {
        emit(FetchedType1State(type1type2model: event.type1model));
      }
      // if (event is FetchedType2Event) {
      //   emit(FetchedType2State(type1type2model: event.type2model));
      // }
    });
  }
  void _convertType1({required ApiResponse apiResponse}) {
    //
    List<dynamic> _listType1Type2 = apiResponse.finalData['data'] as List;

    List<Type1Type2Model> _list =
        _listType1Type2.map((e) => Type1Type2Model.fromJson(e)).toList();

    add(FetchedType1Event(type1model: _list));
  }

  void _convertData(
      {required ApiResponse apiResponse, required BuildContext context}) {
    //
    AlertFlash().showBasicsFlash(
        message: apiResponse.finalData['message'], context: context);
  }
}
