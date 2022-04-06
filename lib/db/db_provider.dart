import 'dart:convert';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/model/signup.dart';
import 'package:wtf_web/session_manager/session_manager.dart';
import 'package:wtf_web/utils/app_const.dart';
import 'package:http/http.dart' as http;

class DBProvider {
  Future<ApiResponse> getGymList() async {
    final response = await http
        .get(Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.GYMS_URI));

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> getGymDetails({required String id}) async {
    final response = await http.get(
        Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.GYM_DETAILS(id)));

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> sendOTP({required String mobile}) async {
    final response = await http.post(
        Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.SEND_OTP_URL),
        body: {"mobile": mobile});

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> getMembershipPlan({required String id}) async {
    final response = await http.get(Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.MEMBERSHIP_PLANS(id)));

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> getOffers({required String id}) async {
    final response = await http
        .get(Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.OFFERS(id)));

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> logIn(
      {required String firstData, required String authenticator}) async {
    SessionManager sessionManager = await SessionManager.getInstance();
    Map<String, dynamic> params = {
      "username": firstData, //"newgymtest@yopmail.com",
      "password": authenticator, //"wtfadmin"
    };
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + '89898887675';
    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.LOGIN_WITH_MAIL_URL,
      ),
      headers: mapHeader,
      body: params,
    );

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] as bool == true) {
      var data = jsonResponse['data'];
      sessionManager.saveProfile(
          name: data["name"] == null ? '' : data["name"],
          email: data["email"] == null ? '' : data["email"],
          id: data["uid"] == null ? '' : data["uid"],
          authToken: data["token"] == '' ? null : data["token"]);
      var _name = await sessionManager.getName();
    }

    // SessionManager.KEY_AUTH_TOKEN =;
    // print('API response LogIn========>' + response.body.toString());

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> signUp(SignupModel userDetails) async {
    Map<String, dynamic> params = {
      "name": userDetails.name,
      "email": userDetails.email,
      "mobile": userDetails.mobile,
      "password": userDetails.password,
      "account_type": userDetails.accountType,
      "status": userDetails.status,
      "referral_code": '',
      "device_details": '',
    };
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + '89898887675';
    // mapHeader["Content-Type"] = "application/json";

    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.SIGNUP_URL,
      ),
      headers: mapHeader,
      body: params,
    );

    logIn(
        firstData: userDetails.email ?? '',
        authenticator: userDetails.password ?? '');
    // SessionManager.KEY_AUTH_TOKEN =;
    // print('API response Signup Body========>${response.body.toString()}');

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ApiResponse> addMembership(
      {required AddMembershipModel membershipModel}) async {
    SessionManager sessionManager = await SessionManager.getInstance();

    var _token = await sessionManager.getToken();
    var _id = await sessionManager.getId();
    var _name = await sessionManager.getName();
    var _email = await sessionManager.getEmail();

    Map<String, dynamic> params = {
      "user_id": _id,
      "name": _name,
      "email": _email,
      "age": membershipModel.age,
      "gender": membershipModel.gender,
      "height": membershipModel.height,
      "weight": membershipModel.weight,
      "target_weight": membershipModel.targetWeight,
      "target_duration": membershipModel.targetDuration,
      "location": "Block C Noida UP",
      "lat": "88585887",
      "long": "25885858",
      "body_type": membershipModel.bodyType,
      "existing_disease": membershipModel.existingDisease,
      "is_smoking": membershipModel.isSmoking,
      "is_drinking": membershipModel.isDrinking,
      "n_token": "N/A",
      "device_id": "N/A",
      "howactive": membershipModel.howactive,
    };
    // AddMembershipModel(
    // userId: membershipModel.userId,
    // name: membershipModel.name,
    // email: membershipModel.email,
    // age: membershipModel.age,
    // gender: membershipModel.gender,
    // height: membershipModel.height,
    // weight: membershipModel.weight,
    // targetWeight: membershipModel.targetWeight,
    // targetDuration: membershipModel.targetDuration,
    // location: membershipModel.location,
    // lat: membershipModel.lat,
    // long: membershipModel.long,
    // bodyType: membershipModel.bodyType,
    // existingDisease: membershipModel.existingDisease,
    // isSmoking: membershipModel.isSmoking,
    // isDrinking: membershipModel.isDrinking,
    // nToken: membershipModel.nToken,
    // deviceId: membershipModel.deviceId,
    // howactive: membershipModel.howactive,
    // ).toJson();
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + _token;
    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.ADD_MEMBERSHIP,
      ),
      headers: mapHeader,
      body: params,
    );

    print('API response add member========>' + response.body.toString());

    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
