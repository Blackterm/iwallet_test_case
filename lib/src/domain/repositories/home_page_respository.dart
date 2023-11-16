import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';

abstract class HomePageRepository {
  Future<List<User>> getUserList();
  Future<UserImage?> getUserImage(String userId);
}
