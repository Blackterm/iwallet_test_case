import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iWallet/src/data/repositories/base_repository.dart';
import 'package:iWallet/src/data/repositories/image_base_repository.dart';
import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';
import 'package:iWallet/src/domain/repositories/home_page_respository.dart';

class DataHomepageRepository implements HomePageRepository {
  static final DataHomepageRepository _instance =
      DataHomepageRepository._internal();
  DataHomepageRepository._internal()
      : _dataBaseRepository = DataBaseRepository(),
        _dataImageBaseRepository = DataImageBaseRepository();
  factory DataHomepageRepository() => _instance;
  final DataBaseRepository _dataBaseRepository;
  final DataImageBaseRepository _dataImageBaseRepository;

  List<User> _userList = [];
  UserImage? _userImage;

  @override
  Future<List<User>> getUserList() async {
    try {
      http.Response response = await _dataBaseRepository.executeRequest(
        "GET",
        "users",
      );

      List jsonResponse = json.decode(response.body);

      _userList =
          jsonResponse.map((currentNew) => User.fromJson(currentNew)).toList();

      return _userList;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<UserImage?> getUserImage(String userId) async {
    try {
      http.Response response = await _dataImageBaseRepository.executeRequest(
        "GET",
        "$userId/info",
      );

      _userImage = UserImage.fromJson(jsonDecode(response.body));

      return _userImage;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
