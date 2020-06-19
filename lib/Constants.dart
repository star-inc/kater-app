import 'package:flutter/material.dart';

// Version
const String versionName = "1.0";

// API
const String apiHost = "https://kater.me/api";

// Strings
const String appTitle = "Kater";
const String websiteURL = "https://kater.me";
const String githubURL = "https://github.com/star-inc/kater-app";
const String idHintText = "Username";
const String pwHintText = "Password";
const String loginButtonText = "Login";
const String noLoginButtonText = "Guest Mode";

// Pages
const String loginPageTag = 'Login Page';
const String newsPageTag = 'News Page';
const String postPageTag = 'Post Page';

// Sizes
const bigRadius = 66.0;
const buttonHeight = 24.0;

// Images
final ImageProvider appLogo = AssetImage('res/images/logo.png');
final ImageProvider defaultAvatar = AssetImage('res/images/avatar.png');
final Image miniLogo = Image.asset('res/images/logo.png', height: 100, width: 100);

// Colors
final Color appBackgroundColor = Color.fromRGBO(255, 255, 255, 1.0);
final Color appButtonColor = Color.fromRGBO(10, 75, 196, .9);
final Color appButtonColor2 = Color.fromRGBO(100, 135, 196, .9);
final Color appItemColor = Color.fromRGBO(10, 120, 226, .9);
final Color horizontalLine = Color.fromRGBO(100, 100, 100, .5);
