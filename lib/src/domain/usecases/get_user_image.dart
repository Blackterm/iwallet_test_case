import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';
import 'package:iWallet/src/domain/repositories/home_page_respository.dart';

class GetUserImage extends UseCase<UserImage?, GetUserImageParams> {
  final HomePageRepository _homePageRepository;

  GetUserImage(this._homePageRepository);
  @override
  Future<Stream<UserImage?>> buildUseCaseStream(
      GetUserImageParams? params) async {
    StreamController<UserImage?> controller = StreamController();
    try {
      UserImage? user = await _homePageRepository.getUserImage(params!.userId);
      controller.add(user);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class GetUserImageParams {
  final String userId;

  GetUserImageParams(this.userId);
}
