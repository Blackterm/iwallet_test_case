import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:iWallet/src/domain/repositories/base_repository.dart';

class DataBaseRepository implements BaseRepository {
  static final DataBaseRepository _instance = DataBaseRepository._internal();
  DataBaseRepository._internal();
  factory DataBaseRepository() => _instance;

  String baseUrl = "https://jsonplaceholder.typicode.com/";

  @override
  Future<Response> executeRequest(String requestType, String path) async {
    Response response;
    var url = Uri.parse(baseUrl + path);

    try {
      switch (requestType) {
        case "GET":
          response = await http.get(
            url,
          );
          break;

        default:
          throw Exception("");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception("");
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
