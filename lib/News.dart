import 'package:flutter/material.dart';

import 'Constants.dart';
import 'models/Post.dart';
import 'models/PostList.dart';
import 'models/PostReceiver.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  int _currentIndex = 0;

  RecordList _records = new RecordList();
  RecordList _filteredRecords = new RecordList();

  String _searchText = "";

  Widget _appBarTitle = new Text(appTitle);

  @override
  void initState() {
    super.initState();

    _records.records = new List();
    _filteredRecords.records = new List();

    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appBackgroundColor,
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: appButtonColor2,
              ),
              title: Text(
                'News',
                style: TextStyle(color: appButtonColor2),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: appButtonColor2,
              ),
              title: Text(
                'New Post',
                style: TextStyle(color: appButtonColor2),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                color: appButtonColor2,
              ),
              title: Text(
                'Category',
                style: TextStyle(color: appButtonColor2),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        elevation: 0.1,
        backgroundColor: appBackgroundColor,
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(
          icon: new CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage("https://kater.me/assets/avatars/pCW0mXYXN0xfit46.png"),
          ),
          onPressed: () {},
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ]
    );
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredRecords.records = new List();
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._filteredRecords
          .records
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.title),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: appItemColor),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24)
                  )),
              child: Hero(
                  tag: "avatar_" + record.title,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(record.avatarUrl),
                  )
              )),
          title: Text(
            record.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: TEST,
                        style: TextStyle(color: Colors.white)),
                      maxLines: 3,
                      softWrap: true,
                    )
                  ]))
            ],),
          trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.of(context).pushNamed(postPageTag);
          }),
      ),
    );
  }
}
