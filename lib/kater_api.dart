import 'dart:convert';
import 'package:http/http.dart' as http;
import 'const.dart';

class KaterAPI {
  Future<List<Map>> fetchNews() async {
    List<Map> result = new List<Map>();
    var response = await http.get(kater_api);
    Map<String, dynamic> news = jsonDecode(response.body);
    news["included"].forEach((item) {
      if(item["type"] == "discussions"){
        result.add(item);
      }
    });
    return result;
  }

  fetchNotifications() async {
    var response = await http.get(kater_api + "/notifications");
    return '${response.body}';
  }
}
