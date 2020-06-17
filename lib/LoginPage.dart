import 'package:flutter/material.dart';
import 'Constants.dart';

class LoginPage extends StatelessWidget {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );
    final title = Text(
        appTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 2,
            fontSize: 35,
            fontStyle: FontStyle.italic,
            foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.blue[500],
        ),
    );
    final id = TextFormField(
      controller: _idController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      autofocus: false,
      decoration: InputDecoration(
          hintText: idHintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintStyle: TextStyle(
              color: Colors.grey
          )
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );
    final password = TextFormField(
      controller: _pwController,
      keyboardType: TextInputType.visiblePassword,
      maxLines: 1,
      autofocus: false,
      decoration: InputDecoration(
          hintText: pwHintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintStyle: TextStyle(
              color: Colors.grey
          )
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {},
        padding: EdgeInsets.all(12),
        color: appButtonColor,
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );
    final noLoginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(homePageTag);
        },
        padding: EdgeInsets.all(12),
        color: appButtonColor2,
        child: Text(noLoginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            title,
            SizedBox(height: bigRadius),
            id,
            SizedBox(height: buttonHeight),
            password,
            SizedBox(height: buttonHeight),
            loginButton,
            Padding(
              padding:EdgeInsets.symmetric(horizontal:10.0),
              child:Container(
                height:1.0,
                width:130.0,
                color:horizontalLine,),
            ),
            noLoginButton
          ],
        ),
      ),
    );
  }
}