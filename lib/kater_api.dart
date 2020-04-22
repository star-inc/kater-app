import 'const.dart';
import 'package:http/http.dart' as http;

class KaterAPI {
  fetchNews() async {
    var response = await http.get(kater_host+api_path);
    return '${response.body}';
  }

  fetchNotifications() async {
    var response = await http.get(kater_host+api_path+"/notifications");
    return '${response.body}';
  }
}