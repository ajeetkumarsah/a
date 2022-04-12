import 'dart:async';
import 'dart:convert';
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './api_service.dart';

class PaymentService {
  final _apiService = ApiService();
  final _timerDuration = const Duration(seconds: 1);
  Timer? _timer;
  Future<void> startPayment(
    int amount,
    String? name,
    String? email,
    VoidCallback onSuccess,
    VoidCallback onFailed,
  ) async {
    String? orderId = await _apiService.createOrder(amount);
    if (orderId == null) {
      onFailed();
      return;
    }
    print('Creating order ===============>');
    final options = {
      'key': 'rzp_live_NhCDSCOuXIM3Ml',
      'amount': amount.toString(), // amount in paisa
      'name': 'WTF',
      'order_id': orderId,
      'prefill': {'name': name, 'email': email},
    };
    if (kIsWeb) {
      final data = await _checkout(options);
      if (data['razorpayStatus'] == 'SUCCESS') {
        print('SuccessFully completed your payment===========>');
        bool verified = await _verifyOrder(data['razorpayOrderId'] ?? '');
        if (verified) {
          onSuccess();
          return;
        }
      }

      onFailed();
    }
  }

  /// starts checkout
  Future<Map<String, String>> _checkout(Map<String, dynamic> options) async {
    Completer<Map<String, String>> completer = Completer<Map<String, String>>();
    // calls js function defined in Step 3
    js.context.callMethod('checkout', [jsonEncode(options)]);
    _timer = Timer.periodic(_timerDuration, (timer) {
      if (html.window.sessionStorage.containsKey('razorpayStatus')) {
        Map<String, String> data = Map.fromEntries(
          html.window.sessionStorage.entries,
        );
        html.window.sessionStorage.clear();
        completer.complete(data);
        _timer!.cancel();
        _timer = null;
      }
    });
    return completer.future;
  }

  /// verify order signature
  Future<bool> _verifyOrder(
    String razorpayOrderId,
  ) async {
    return _apiService.verifyPayment(
      {
        'razorpay_payment_id': razorpayOrderId,
      },
    );
  }
}
