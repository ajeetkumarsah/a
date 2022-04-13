import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/login_response.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _repository = Repository();

  final _controller = TextEditingController();
  bool _passwordVisible = false;
  bool get passwordVisible => this._passwordVisible;

  set passwordVisible(bool value) => this._passwordVisible = value;
  SessionManager sessionManager = SessionManager.getInstance();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      if (event is OnLoginEvent) {
        _repository
            .postLogin(
                firstData: event.firstData, authenticator: event.authenticator)
            .then((value) => _loginStatus(apiResponse: value));
      }
      if (event is LoginStatusEvent) {
        emit(LoginStatusState(
          loginDetails: event.loginDetails,
          isSuccess: event.isSuccess,
          msg: event.msg,
        ));
      }
    });
  }
  void _saveUserProfile({required ApiResponse apiResponse}) {
    LoginResponse _loginResponse =
        LoginResponse.fromJson(apiResponse.finalData['data']);

    sessionManager.saveProfile(
        name: _loginResponse.name ?? '',
        email: _loginResponse.email ?? '',
        id: _loginResponse.uid ?? '',
        authToken: _loginResponse.token ?? '');
  }

  void _loginStatus({required ApiResponse apiResponse}) {
    bool isTrue = apiResponse.finalData['status'];

    if (isTrue) {
      LoginResponse _loginResponse =
          LoginResponse.fromJson(apiResponse.finalData['data']);

      add(LoginStatusEvent(
          isSuccess: true,
          msg: apiResponse.finalData['message'],
          loginDetails: _loginResponse));

      _saveUserProfile(apiResponse: apiResponse);
    } else {
      add(
        LoginStatusEvent(
            isSuccess: false,
            msg: apiResponse.finalData['message'],
            loginDetails: LoginResponse()),
      );
    }
  }
}
