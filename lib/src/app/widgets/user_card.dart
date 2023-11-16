import 'package:flutter/material.dart';
import 'package:iWallet/src/app/constants/constants.dart';
import 'package:iWallet/src/domain/entities/user.dart';
import 'package:iWallet/src/domain/entities/user_image.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    required this.users,
    required this.userImages,
  });
  final List<User> users;
  final List<UserImage> userImages;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.all(18),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: ListTile(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      content: Stack(
                        children: [
                          Container(
                            width: size.width,
                            child: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ClipOval(
                                                child: SizedBox.fromSize(
                                                  size: Size.fromRadius(60),
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        userImages[index]
                                                            .downloadUrl!),
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        AssetImage(placeholder),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              users[index].name ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text('@${users[index].username}')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text('Email: ${users[index].email}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child:
                                        Text('Telefon: ${users[index].phone}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                        'Adres: ${users[index].address!.street}, ${users[index].address!.suite}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                        'Şehir: ${users[index].address!.city}'),
                                  ),
                                  Text(
                                      'Konum: ${users[index].address!.geo!.lat} /${users[index].address!.geo!.lng}'),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: InkWell(
                                child: Icon(Icons.close),
                                onTap: () => Navigator.pop(context),
                              )),
                        ],
                      ),
                    );
                  },
                );
              },
              leading: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(25), // Image radius
                  child: FadeInImage(
                    image: NetworkImage(userImages[index].downloadUrl!),
                    fit: BoxFit.fill,
                    placeholder: AssetImage(placeholder),
                  ),
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  users[index].name ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              subtitle: Text(
                users[index].username ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              shape: Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ));
      },
    );
  }
}
