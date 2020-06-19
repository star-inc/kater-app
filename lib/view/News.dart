import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:kater/Constants.dart';
import 'package:kater/view/AboutWidget.dart';
import 'package:kater/compute/PostList.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {

  int _offset;
  PostList _post = new PostList();
  PostList _filteredPosts = new PostList();

  String _searchText = "";

  Widget _appBarTitle = new Text(appTitle);

  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _offset = 0;
    _post.post.clear();
    _filteredPosts.post.clear();
    _getPosts(_offset);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _offset += 20;
    _getPosts(_offset);
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _post.post = new List();
    _filteredPosts.post = new List();
  }

  void _getPosts(int offset) async {
    PostList post = await PostService().loadPosts(offset);
    setState(() {
      for (Post post in post.post) {
        this._post.post.add(post);
        this._filteredPosts.post.add(post);
      }
    });
  }

  void _avatarMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          title: new Text('Kater User'),
          content: Container(
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new SizedBox(
                  height: 5.0,
                ),
                new InkWell(
                  child: new Container(
                    height: 45,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.toys),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text('Profile'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
                new SizedBox(
                  height: 5.0,
                ),
                new InkWell(
                  child: new Container(
                    height: 45,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.exit_to_app),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
                new SizedBox(
                  height: 5.0,
                ),
                new InkWell(
                  child: new Container(
                    height: 45,
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.info),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: new Text('About'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => aboutWidget(context),
                ),
              ],
            ),
          ),
        );
      },
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
            backgroundImage: defaultAvatar,
          ),
          onPressed: () => _avatarMenu(context),
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ]);
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredPosts.post = new List();
      for (int i = 0; i < _post.post.length; i++) {
        if (_post.post[i].title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredPosts.post.add(_post.post[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._filteredPosts
          .post
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Post post) {
    return Card(
      key: ValueKey(post.title),
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
                        right:
                            new BorderSide(width: 1.0, color: Colors.white24))),
                child: Hero(
                    tag: "avatar_" + post.title,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: post.authorAvatarUrl != null ? NetworkImage(post.authorAvatarUrl) : defaultAvatar,
                    ))),
            title: Text(
              post.title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                new Flexible(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: post.authorName,
                            style: TextStyle(color: Colors.white)),
                        maxLines: 3,
                        softWrap: true,
                      )
                    ]))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(postPageTag, arguments: {"discussionId": post.id});
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appBackgroundColor,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = Text("Loading");
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _buildList(context),
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 75,
        height: 55,
        child: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {},
        ),
        decoration: BoxDecoration(
            color: appButtonColor,
            shape: BoxShape.circle
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.pages),
              onPressed: () {},
            ),
            SizedBox(),
            IconButton(
              icon: Icon(Icons.category),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
