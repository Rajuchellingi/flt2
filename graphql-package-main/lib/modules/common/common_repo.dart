import 'dart:convert';

import '../../config/configConstant.dart';
import 'base_client.dart';

class CommonRepo {
  Future getTemplate() async {
    var result = await BaseClient().get(
        'https://j7977r6byh.execute-api.ap-south-1.amazonaws.com/qa/',
        'template/' + shopId);
    if (result == null) return;
    return jsonDecode(result);
  }
}
