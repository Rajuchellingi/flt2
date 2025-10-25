import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:integration_package/modules/review/review_model.dart';

class ReviewRepo {
  Future getProduct(params) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'judge.me',
      path: '/api/v1/products/-1',
      queryParameters: params,
    );
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return reviewProductFromJson(data['product']);
    } else {
      return null;
    }
  }

  Future getReviews(params) async {
    try {
      Map<String, String> headers = {
        'Content-Type': "application/json",
      };
      Uri uri = Uri(
        scheme: 'https',
        host: 'judge.me',
        path: '/api/v1/reviews',
        queryParameters: params,
      );
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return reviewDataFromJson(data);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future getReviewCount(params) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'judge.me',
      path: '/api/v1/reviews/count',
      queryParameters: params,
    );
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future getReviewWidget(params) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'judge.me',
      path: '/api/v1/widgets/preview_badge',
      queryParameters: params,
    );
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future createReview(body) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'judge.me',
      path: '/api/v1/reviews',
    );
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);
    var responseBody = jsonDecode(response.body);
    var data = {
      "status": response.statusCode,
      "message": responseBody['message'],
    };
    return data;
  }

  Future updateReview(id, params, body) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
    };
    Uri uri = Uri(
      scheme: 'https',
      host: 'judge.me',
      path: '/api/v1/reviews/$id',
      queryParameters: params,
    );
    final response = await http.put(
      uri,
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future getNectorReview(id, apikey) async {
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'x-apikey': apikey,
      'x-source': 'mobile'
    };

    Uri uri = Uri(
      scheme: 'https',
      host: 'cachefront.nector.io',
      path: 'api/v2/merchant/reviews-count',
      queryParameters: {
        "reference_product_source": "shopify",
        "reference_product_id": id
      },
    );
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['data'] != null && jsonData['data']['countsum'] != null) {
        return jsonData['data']['countsum'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
