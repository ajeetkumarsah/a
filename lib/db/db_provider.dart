import 'dart:convert';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/utils/app_const.dart';
import 'package:http/http.dart' as http;

class DBProvider {
// final _jsonDecoder=jsonDecode();
  Future<ApiResponse> getGymList() async {
    final response = await http
        .get(Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.GYMS_URI));

// print('API response Gyms List========>'+response.body.toString());
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

// print('API response Gyms Details========>'+response.body.toString());
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

    print('API response Gym========>$id');
    print('API response Membership Plans========>' + response.body.toString());
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

    // print('API response Offers========>' + response.body.toString());
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
}
