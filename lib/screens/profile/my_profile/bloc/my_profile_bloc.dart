import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/subscription.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final _repository = Repository();
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileEvent>((event, emit) {
      if (event is FetchSubscriptionEvent) {
        emit(MyProfileInitial());

        _repository
            .getGymList(userId: event.type)
            .then((value) => _convertGymList(apiResponse: value));
      }

      if (event is FetchedSubscriptionEvent) {
        emit(FetchedSubscriptionState(subscription: event.subscription));
      }
    });
  }
  void _convertGymList({required ApiResponse apiResponse}) {
    List<dynamic> _gymList = apiResponse.finalData['data'] as List;

    List<SubscriptionModel> _list =
        _gymList.map((e) => SubscriptionModel.fromJson(e)).toList();

    add(FetchedSubscriptionEvent(subscription: _list));
  }
}
