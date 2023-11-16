import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as c;
import 'package:iWallet/src/app/constants/constants.dart';
import 'package:iWallet/src/app/pages/home/home_controller.dart';
import 'package:iWallet/src/app/widgets/user_card.dart';
import 'package:iWallet/src/data/repositories/home_page_repository.dart';

class HomeView extends c.View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(DataHomepageRepository()));
  }
}

class _HomeViewState extends c.ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
            toolbarHeight: size.height * 0.15,
            backgroundColor: cPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            title: c.ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) {
                return Column(
                  children: [
                    Text(title),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: controller.searchEditingController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          controller.searchTaxpayer(value);
                        },
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: searchUser,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.grey,
                            onPressed: () => controller.clearTextField(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
        body: Container(
          child: c.ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) {
            return controller.usersList != null &&
                    controller.usersList!.length != 0 &&
                    controller.userImageList != null &&
                    controller.userImageList!.length != 0
                ? controller.searchEditingController.text.isNotEmpty &&
                        controller.filterUsersList!.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text('Kullanıcı Bulunamadı!'),
                          ),
                        ],
                      )
                    : !controller.filterUsersList!.isNotEmpty &&
                            controller.searchEditingController.text.length == 0
                        ? UserCard(
                            users: controller.usersList!,
                            userImages: controller.userImageList!,
                          )
                        : UserCard(
                            users: controller.filterUsersList!,
                            userImages: controller.userImageList!,
                          )
                : Center(child: CircularProgressIndicator());
          }),
        ));
  }
}
