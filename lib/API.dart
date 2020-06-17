import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Constants.dart';

class KaterAPI {
  getHome() async {
    final response = await http.get(apiHost);
    return json.decode(response.body);
  }

  getNews() async {
    final response = await http.get(apiHost + "/discussions");
    return json.decode(response.body);
  }

  fetchNotifications() async {
    final response = await http.get(apiHost + "/notifications");
    return json.decode(response.body);
  }
}
