import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';
import 'package:iWallet/src/domain/repositories/home_page_respository.dart';
import 'home_presenter.dart';

class HomeController extends Controller {
  HomePresenter _presenter;

  HomeController(HomePageRepository homePageRepository)
      : _presenter = HomePresenter(homePageRepository);

  bool islistFetched = false;
  bool isImagelistFetched = false;

  List<User>? usersList = [];
  List<User>? filterUsersList = [];
  List<UserImage>? userImageList = [];
  TextEditingController searchEditingController = TextEditingController();

  @override
  void onInitState() async {
    _presenter.getUserList();
  }

  @override
  void initListeners() {
    _presenter.getUserListOnNext = (List<User>? response) async {
      if (response == null) return;
      if (response.isNotEmpty) {
        if (!islistFetched) {
          usersList = response;
          refreshUI();
          usersList!.forEach((element) {
            _presenter.getUserImage(element.id.toString());
          });
        }
      }
    };

    _presenter.getUserImageOnNext = (UserImage? response) async {
      if (response == null) return;

      if (!isImagelistFetched) {
        userImageList!.add(response);
        if (userImageList!.length == usersList!.length) {
          refreshUI();
        }
      }
    };

    _presenter.getUserListOnError = (e) {
      log(e);
    };

    _presenter.getUserImageOnError = (e) {
      log(e);
    };
  }

  void searchTaxpayer(String value) {
    filterUsersList = usersList!
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    refreshUI();
  }

  void clearTextField() {
    searchEditingController.clear();
    filterUsersList!.clear();
    refreshUI();
  }
}
