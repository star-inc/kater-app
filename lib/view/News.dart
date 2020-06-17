import 'package:flutter/material.dart';
import 'package:kater/Constants.dart';
import 'package:kater/compute/PostList.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  int _currentIndex = 0;

  PostList _post = new PostList();
  PostList _filteredPosts = new PostList();

  String _searchText = "";

  Widget _appBarTitle = new Text(appTitle);

  @override
  void initState() {
    super.initState();

    _post.post = new List();
    _filteredPosts.post = new List();

    _getPosts();
  }

  void _getPosts() async {
    PostList post = await PostService().loadPosts();
    setState(() {
      for (Post post in post.post) {
        this._post.post.add(post);
        this._filteredPosts.post.add(post);
      }
    });
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
            backgroundImage: NetworkImage(
                "https://kater.me/assets/avatars/pCW0mXYXN0xfit46.png"),
          ),
          onPressed: () {},
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
                      backgroundImage: NetworkImage(post.authorAvatarUrl),
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
              Navigator.of(context).pushNamed(
                postPageTag,
                arguments: {
                  "discussionId": post.id
                });
            }),
      ),
    );
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
}
