import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import 'package:iWallet/src/domain/repositories/image_base_repository.dart';

class DataImageBaseRepository implements ImageBaseRepository {
  static final DataImageBaseRepository _instance =
      DataImageBaseRepository._internal();
  DataImageBaseRepository._internal();
  factory DataImageBaseRepository() => _instance;

  String baseUrl = "https://picsum.photos/id/";

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
