import 'package:flutter/material.dart';
import 'Constants.dart';
import 'LoginPage.dart';
import 'PostPage.dart';
import 'News.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    newsPageTag: (context) => NewsPage(),
    postPageTag: (context) => PostPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: new ThemeData(
          primaryColor: appBackgroundColor,
        ),
        home: LoginPage(),
        routes: routes
    );
  }
}