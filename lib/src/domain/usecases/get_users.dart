import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/repositories/home_page_respository.dart';

class GetUserList extends UseCase<List<User>, void> {
  final HomePageRepository _homePageRepository;

  GetUserList(this._homePageRepository);
  @override
  Future<Stream<List<User>?>> buildUseCaseStream(void params) async {
    StreamController<List<User>> controller = StreamController();
    try {
      List<User> users = await _homePageRepository.getUserList();
      controller.add(users);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}
