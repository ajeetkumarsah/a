import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/db/repository.dart';
import 'package:wtf_web/model/signup.dart';
import 'package:wtf_web/model/signup_response.dart';
import 'package:wtf_web/session_manager/session_manager.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final _repository = Repository();
  String? otp;
  String? get getOtp => this.otp;

  set setOtp(String? otp) => this.otp = otp;
  bool _passwordVisible = false, _confirmpasswordVisible = false;
  bool get confirmpasswordVisible => this._confirmpasswordVisible;

  set confirmpasswordVisible(bool value) =>
      this._confirmpasswordVisible = value;
  bool get passwordVisible => this._passwordVisible;

  set passwordVisible(bool value) => this._passwordVisible = value;
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {
      if (event is SendOTPEvent) {
        emit(SignupInitial());

        _repository
            .sendOTP(mobile: event.mobile)
            .then((value) => _convertOtp(apiResponse: value));
      }
      if (event is PostSignupEvent) {
        _repository
            .postSignup(userDetails: event.signupDetails)
            .then((value) => _signupStatus(apiResponse: value));
      }
      // if(event is )
      if (event is FetchOtpEvent) {
        emit(FetchOtpState(event.otp));
      }
      if (event is SendOTPEvent) {
        emit(SendOTPState(mobile: event.mobile));
      }
      if (event is FetchSignupEvent) {
        emit(FetchSignupState(id: event.id));
      }
      if (event is SignupSuccessEvent) {
        emit(SignupSuccessState(isSuccess: event.isSuccess, msg: event.msg));
      }
    });
  }
  void _convertOtp({required ApiResponse apiResponse}) {
    var _otp = apiResponse.finalData['data']['otp'];
    print('Sent OTP================>' + otp.toString());
    add(FetchOtpEvent(otp: _otp));
  }

  void _saveUserProfile({required ApiResponse apiResponse}) async {
    SessionManager sessionManager = await SessionManager.getInstance();
    // sessionManager.saveProfile(authToken: '', id: '');
    print('User Profile Saved after Signup============>');
  }

  // void _signupStatus({required ApiResponse apiResponse}) {
  //   bool isTrue = apiResponse.finalData['status'];
  //   if (isTrue) {
  //     add(SignupSuccessEvent(
  //         isSuccess: true, msg: apiResponse.finalData['message']));

  //     _saveUserProfile(apiResponse: apiResponse);
  //   } else {
  //     add(SignupSuccessEvent(
  //         isSuccess: false, msg: apiResponse.finalData['message']));
  //   }
  // }

  void _signupStatus({required ApiResponse apiResponse}) {
    bool isTrue = apiResponse.finalData['status'];

    if (isTrue) {
      SignupResponse _signupRespose =
          SignupResponse.fromJson(apiResponse.finalData['data']);

      add(SignupStatusEvent(
          isSuccess: true,
          msg: apiResponse.finalData['message'],
          signupResponse: _signupRespose));

      _saveUserProfile(apiResponse: apiResponse);
    } else {
      add(
        SignupStatusEvent(
            isSuccess: false,
            msg: apiResponse.finalData['message'],
            signupResponse: SignupResponse()),
      );
    }
  }
}
