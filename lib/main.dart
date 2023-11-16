import 'package:flutter/material.dart';
import 'package:iWallet/src/app/pages/home/home_view.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iWallet',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
