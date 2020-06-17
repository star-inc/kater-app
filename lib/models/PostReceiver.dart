import 'PostList.dart';
import '../API.dart';

class RecordService {
  final apiClient = KaterAPI();
  Future<RecordList> loadRecords() async {
    var jsonResponse = await apiClient.getNews();
    RecordList records = new RecordList.fromJson(jsonResponse["data"]);
    return records;
  }
}