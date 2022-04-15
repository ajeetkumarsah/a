import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileEvent>((event, emit) {
      if (event is FetchSubscriptionEvent) {
        //
      }
    });
  }
}
