import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/member_info.dart';
import 'package:wtf_web/model/user_profile.dart';
import 'package:wtf_web/session_manager/global_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _repository = Repository();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      if (event is FetchProfileEvent) {
        emit(ProfileInitial());
        print('Inside FetchProfileEvent=========>');
        _repository
            .getUserInfo()
            .then((value) => _convertData(apiResponse: value));
      }
      if (event is FetchUserInfoEvent) {
        emit(FetchUserInfoState(userInfo: event.userInfo));
        //
      }
    });
  }
  _convertData({required ApiResponse apiResponse}) {
    UserProfile _userInfo = UserProfile.fromJson(apiResponse.finalData['data']);

    GlobalData().setUserProfile = _userInfo;
    // print('Inside UserInfo=========>');
    add(FetchUserInfoEvent(userInfo: _userInfo));
  }
}
