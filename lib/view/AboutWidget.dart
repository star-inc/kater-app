import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kater/Constants.dart';

void aboutWidget(BuildContext context) {
    _launchGitHubURL() async {
      if (await canLaunch(githubURL)) {
        await launch(githubURL);
      } else {
        throw 'Could not launch $githubURL';
      }
    }
    _launchWebsiteURL() async {
      if (await canLaunch(websiteURL)) {
        await launch(websiteURL);
      } else {
        throw 'Could not launch $websiteURL';
      }
    }
    showAboutDialog(
    context: context,
    applicationIcon: miniLogo,
    applicationName: 'Kater',
    applicationVersion: 'Version: $versionName',
    applicationLegalese: '(c) 2020 Star Inc.',
    children: <Widget>[
      new SizedBox(
        height: 25.0,
      ),
      new Text('This is the official mobile client for'),
      new RaisedButton(
        onPressed: _launchWebsiteURL,
        child: Text('Kater ($websiteURL).', style: TextStyle(color: Colors.blue),),
        color: Colors.white,
        elevation: 0,
      ),
      new Text('Designed by Star Inc.'),
      Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
        child: Container(
          height: 1.0,
          width: 130.0,
          color: horizontalLine,
        ),
      ),
      new Text('This is an opensource software.'),
      new SizedBox(
        height: 10.0,
      ),
      new Text('The application is licenced under'),
      new RaisedButton(
        onPressed: _launchGitHubURL,
        child: Text('Apache LICENSE v. 2.0.', style: TextStyle(color: Colors.blue)),
        color: Colors.white,
        elevation: 0,
      ),
      new Text('You may obtain the source from GitHub repository.'),
    ],
  );
}
