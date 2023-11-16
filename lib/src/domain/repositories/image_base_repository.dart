import 'package:http/http.dart';

abstract class ImageBaseRepository {
  Future<Response> executeRequest(String requestType, String path);
}
