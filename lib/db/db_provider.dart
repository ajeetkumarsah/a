import 'dart:convert';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/model/signup.dart';
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

  Future<ApiResponse> logIn(LoginModel user) async {
    Map<String, dynamic> params = {
      "username": user.email, //"newgymtest@yopmail.com",
      "password": user.password, //"wtfadmin"
    };

    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.LOGIN_WITH_MAIL_URL,
      ),
      body: params,
    );
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
      "username": userDetails.email, //"newgymtest@yopmail.com",
      "password": userDetails.password, //"wtfadmin"
    };

    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.LOGIN_WITH_MAIL_URL,
      ),
      body: params,
    );
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

  Future<ApiResponse> addMembership(
      {required AddMembershipModel membershipModel, required String id}) async {
    Map<String, dynamic> params = AddMembershipModel(
      userId: membershipModel.userId,
      name: membershipModel.name,
      email: membershipModel.email,
      age: membershipModel.age,
      gender: membershipModel.gender,
      height: membershipModel.height,
      weight: membershipModel.weight,
      targetWeight: membershipModel.targetWeight,
      targetDuration: membershipModel.targetDuration,
      location: membershipModel.location,
      lat: membershipModel.lat,
      long: membershipModel.long,
      bodyType: membershipModel.bodyType,
      existingDisease: membershipModel.existingDisease,
      isSmoking: membershipModel.isSmoking,
      isDrinking: membershipModel.isDrinking,
      nToken: membershipModel.nToken,
      deviceId: membershipModel.deviceId,
      howactive: membershipModel.howactive,
    ).toJson();

    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.ADD_MEMBERSHIP(id),
      ),
      body: params,
    );
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
}
