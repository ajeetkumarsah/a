import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/type1_type2.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final _repository = Repository();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is PostOnboardingEvent) {
        _repository.postNewMember(memberShip: event.memberShip).then((value) {
          print('Printing the values: ' + value.toString());
        });
      }
      if (event is FetchType1Event) {
        emit(OnboardingInitial());
        print('Api call FetchType1Event============>');
        _repository
            .postType1Type2(type: event.type)
            .then((value) => _convertType1(apiResponse: value));
      }
      if (event is FetchType2Event) {
        emit(OnboardingInitial());
        print('Api call FetchType2Event============>');
        _repository
            .postType1Type2(type: event.type)
            .then((value) => _convertType2(apiResponse: value));
      }

      if (event is FetchedType1Event) {
        emit(FetchedType1State(type1type2model: event.type1model));
      }
      if (event is FetchedType2Event) {
        emit(FetchedType2State(type1type2model: event.type2model));
      }
    });
  }
  void _convertType1({required ApiResponse apiResponse}) {
    //
    List<dynamic> _listType1Type2 = apiResponse.finalData['data'] as List;

    List<Type1Type2Model> _list =
        _listType1Type2.map((e) => Type1Type2Model.fromJson(e)).toList();

    add(FetchedType1Event(type1model: _list));
  }

  void _convertType2({required ApiResponse apiResponse}) {
    //
    List<dynamic> _listType1Type2 = apiResponse.finalData['data'] as List;

    List<Type1Type2Model> _list =
        _listType1Type2.map((e) => Type1Type2Model.fromJson(e)).toList();

    add(FetchedType2Event(type2model: _list));
  }
}
