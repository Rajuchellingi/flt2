import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:integration_package/config/configConstant.dart';

class SizeChartRepo {
  Future getSizeChart(params) async {
    Map<String, String> headers = {
      'client-id': shopId,
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: '73dlo1m5qk.execute-api.ap-south-1.amazonaws.com',
      path: '/prod/getSizeCharts',
      queryParameters: params,
    );
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
