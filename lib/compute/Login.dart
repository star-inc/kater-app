import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kater/Constants.dart';

class KaterAccess {
  getAccess(String identification, String password) async {
    final response = await http.post(
        authHost, body: {
          'identification': identification, 'password': password
        });
    return json.decode(response.body);
  }
}