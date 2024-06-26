import 'package:http/http.dart';

abstract class BaseRepository {
  Future<Response> executeRequest(String requestType, String path);
}
