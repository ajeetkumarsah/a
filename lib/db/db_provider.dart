import 'dart:convert';
import 'package:wtf_web/db/api_response.dart';
import 'package:wtf_web/model/add_membership.dart';
import 'package:wtf_web/model/login.dart';
import 'package:wtf_web/model/post_order_id.dart';
import 'package:wtf_web/model/signup.dart';
import 'package:wtf_web/service/payment_service.dart';
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
    print('OTP API Response===========>' + response.body.toString());
    if (response.statusCode == 200) {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Error',
          networkStatus: false,
          status: false);
      // throw Exception('Failed to load post');
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
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Failed to login!',
          networkStatus: false,
          status: false);
      // throw Exception('Failed to load post');
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

    // SessionManager.KEY_AUTH_TOKEN =;
    print('API response Signup Body========>${response.body.toString()}');

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status' as bool == true]) {
        print('Calling Login API=======>');
        logIn(
            firstData: userDetails.email ?? '',
            authenticator: userDetails.password ?? '');
      }
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Success',
          networkStatus: false,
          status: false);
    } else {
      return ApiResponse(
          finalData: jsonDecode(response.body),
          error: 'Failed to Signup!',
          networkStatus: false,
          status: false);
      // throw Exception('Failed to load post');
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

//TODO GENERATE ORDER ID
  Future<ApiResponse> generateOrderId() async {
    final response = await http.post(
        Uri.parse(AppConstants.BASE_URL_DEV + AppConstants.SEND_OTP_URL),
        body: {"mobile": 'mobile'});

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

  Future<ApiResponse> getOrderId(
      {required PostOrderIdModel postOrderIdModel}) async {
    SessionManager sessionManager = await SessionManager.getInstance();

    var _token = await sessionManager.getToken();
    var _id = await sessionManager.getId();

    print('API response Bearer tocken========>' + _token.toString());
    print('API response Id========>' + _id.toString());
    Map<String, dynamic> mainBody = {
      "gym_id": "GLKdIYAWDS2Q8",
      "user_id": _id.toString(),
      "price": 99,
      "trx_id": "pay_IyGO5WcugRuuy7",
      "trx_status": "done",
      "tax_percentage": 18,
      "tax_amount": 18,
      "type": "regular",
      "order_status": "done",
      "slot_id": "",
      "addon": "",
      "start_date": "21-02-2022",
      "expire_date": "22-03-2022",
      "coupon": "N/A",
      "plan_id": "VRvEG5iwBn6zi",
      "remark": "New Subscription",
      "event_id": "",
      "order_id": "",
      "session_id": "",
      "isWhatsapp": true
    };
    Map<String, dynamic> params = {
      "amount": postOrderIdModel.amount,
      "user_id": _id.toString(),
      "value": mainBody.toString()
    };

    print('API response Get order id========>');
    Map<String, String> mapHeader = Map();
    mapHeader["Authorization"] = "Bearer " + _token;
    final response = await http.post(
      Uri.parse(
        AppConstants.BASE_URL_DEV + AppConstants.GET_ORDER_ID,
      ),
      headers: mapHeader,
      body: params,
    );

    print('API response Order iD========>' + response.body.toString());

    if (response.statusCode == 200) {
      // if (jsonDecode(response.body)['status'] as bool == true) {
      //   //

      // }
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
