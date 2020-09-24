import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NetworkHelper {
  String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    try {
      var response = await get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(jsonDecode(response.body));
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
