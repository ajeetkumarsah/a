import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/add_membership.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final _repository = Repository();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is PostOnboardingEvent) {
        print('Api call Onboarding============>');
        _repository.postNewMember(memberShip: event.memberShip).then((value) {
          print('Printing the values: ' + value.toString());
        });
      }
    });
  }
}
