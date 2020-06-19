import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kater/Constants.dart';

class NewPostPage extends StatelessWidget {
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = Text(
      "New Article",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.italic,
      ),
    );
    final subject = TextFormField(
      controller: _subjectController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      maxLength: 10,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Subject",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintStyle: TextStyle(color: Colors.grey)),
      style: TextStyle(
        color: Colors.black,
      ),
    );
    final content = TextFormField(
      controller: _contentController,
      keyboardType: TextInputType.text,
      maxLines: 20,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Content",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.grey)),
      style: TextStyle(
        color: Colors.black,
      ),
    );
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {},
        padding: EdgeInsets.all(12),
        color: appButtonColor,
        child: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: title,
        leading: BackButton(),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 15),
            subject,
            SizedBox(height: 5),
            content,
            SizedBox(height: 5),
            submitButton
          ],
        ),
      ),
    );
  }
}
