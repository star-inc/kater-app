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
      new Text('This is the mobile client for Kater($websiteURL).'),
      new SizedBox(
        height: 10.0,
      ),
      new Text('Apache'),
      new SizedBox(
        height: 10.0,
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: new RaisedButton(
              onPressed: _launchWebsiteURL,
              child: Text("Kater"),
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: new RaisedButton(
              onPressed: _launchGitHubURL,
              child: Text("GitHub"),
              color: Colors.white,
            ),
          ),
        ],
      )
    ],
  );
}
