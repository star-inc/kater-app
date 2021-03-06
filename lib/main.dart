import 'package:flutter/material.dart';

import 'package:kater/Constants.dart';
import 'package:kater/view/LoginPage.dart';
import 'package:kater/view/News.dart';
import 'package:kater/view/Discussion.dart';
import 'package:kater/view/NewPost.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    newsPageTag: (context) => NewsPage(),
    postPageTag: (context) => PostPage(),
    newPostPageTag: (context) => NewPostPage(),
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
        routes: routes);
  }
}
