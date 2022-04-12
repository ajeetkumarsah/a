import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wtf_web/utils/app_const.dart';

import '../session_manager/session_manager.dart';

class ApiService {
  /// to create order for initiating payment
  ///@param amount in paisa
  Future<String?> createOrder(int amount) async {
    try {
      // final res = await _post('https://api.wtfup.me/createOrder', {
      //   'amount': amount,
      // });
      SessionManager sessionManager = await SessionManager.getInstance();

      var _token = await sessionManager.getToken();
      var _id = await sessionManager.getId();
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
        "amount": amount.toString(),
        "user_id": _id.toString(),
        "value": mainBody.toString()
      };

      print('API response Get order id from API Service========>');
      Map<String, String> mapHeader = Map();
      mapHeader["Authorization"] = "Bearer " + _token;
      final response = await http.post(
        Uri.parse(
          AppConstants.BASE_URL_DEV + AppConstants.GET_ORDER_ID,
        ),
        headers: mapHeader,
        body: params,
      );
      if (response.statusCode == 200) {
        print('Getting Your order id============>');
        final data = jsonDecode(response.body);
        print('Your order id is============>' +
            data['data']['order_id'].toString());
        return data['data']['order_id'].toString();
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  /// verify the payment
  Future<bool> verifyPayment(Map<String, dynamic> body) async {
    try {
      final res = await _post(
        AppConstants.BASE_URL_DEV + AppConstants.VERIFY_PAYMENT_URL,
        body,
      );
      return res.statusCode == 200;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  /// send post request
  Future<http.Response> _post(
    String url,
    Map<String, dynamic> body,
  ) async {
    return http
        .post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(Duration(seconds: 10));
  }
}
