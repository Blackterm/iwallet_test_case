import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';
import 'package:iWallet/src/domain/repositories/home_page_respository.dart';
import 'package:iWallet/src/domain/usecases/get_user_image.dart';
import 'package:iWallet/src/domain/usecases/get_users.dart';

class HomePresenter extends Presenter {
  late Function getUserListOnNext;
  late Function getUserListOnError;

  late Function getUserImageOnNext;
  late Function getUserImageOnError;

  final GetUserList _getUserList;
  final GetUserImage _getUserImage;

  HomePresenter(HomePageRepository _homePageRepository)
      : _getUserList = GetUserList(_homePageRepository),
        _getUserImage = GetUserImage(_homePageRepository);

  void getUserList() {
    _getUserList.execute(_GetUserListObserver(this));
  }

  void getUserImage(String userId) {
    _getUserImage.execute(
        _GetUserImageObserver(this), GetUserImageParams(userId));
  }

  @override
  void dispose() {
    _getUserList.dispose();
    _getUserImage.dispose();
  }
}

class _GetUserListObserver extends Observer<List<User>> {
  final HomePresenter _presenter;

  _GetUserListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getUserListOnError(e);
  }

  @override
  void onNext(List<User>? response) {
    _presenter.getUserListOnNext(response);
  }
}

class _GetUserImageObserver extends Observer<UserImage> {
  final HomePresenter _presenter;

  _GetUserImageObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getUserImageOnError(e);
  }

  @override
  void onNext(UserImage? response) {
    _presenter.getUserImageOnNext(response);
  }
}
