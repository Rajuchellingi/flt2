import 'dart:convert';

import 'package:http/http.dart' as http;

class OTPRepo {
  Future generatePrizmaOTP(params, body, apiKey) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'X-PRIZMA-LOGIN-API-KEY': apiKey
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'prizmalogin.prizmacommerce.com',
      path: '/prizmalogin/v1/otp/generateotp',
      queryParameters: params,
    );
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data?['otpGenerationRequest'];
    } else {
      return null;
    }
  }

  Future verifyPrizmaOTP(params, body, apiKey) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'X-PRIZMA-LOGIN-API-KEY': apiKey
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'prizmalogin.prizmacommerce.com',
      path: '/prizmalogin/v1/otp/verifyotp',
      queryParameters: params,
    );
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data?['customer'];
    } else {
      return data;
    }
  }

  Future completeregistration(params, body, apiKey) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'X-PRIZMA-LOGIN-API-KEY': apiKey
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'prizmalogin.prizmacommerce.com',
      path: '/prizmalogin/v1/otp/completeregistration',
      queryParameters: params,
    );
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data?['customer'];
    } else {
      return null;
    }
  }
}
