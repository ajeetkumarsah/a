import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/model/login_response.dart';
import 'package:wtf_web/session_manager/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _repository = Repository();

  final _controller = TextEditingController();
  SessionManager sessionManager = SessionManager.getInstance();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      if (event is PostLogInEvent) {
        emit(LoginInitial());
        _repository
            .postLogin(userDetails: event.loginDetails)
            .then((value) => _convertGymDetails(apiResponse: value));
        print('Converting data============>');
      }
    });
  }
  void _convertGymDetails({required ApiResponse apiResponse}) {
    LoginResponse _loginResponse =
        LoginResponse.fromJson(apiResponse.finalData['data']);
    print('Binding data with model============>');
    sessionManager.saveProfile(
        id: _loginResponse.uid ?? '',
        name: _loginResponse.name ?? '',
        emailId: _loginResponse.email ?? '',
        authToken: _loginResponse.token ?? '',
        uid: _loginResponse.uid ?? '');
    print('User Profile Saved============>');

    add(FetchLoginEvent(loginResponse: _loginResponse));
  }
}
