import 'package:flutter/material.dart';
import 'package:kater/Constants.dart';
import 'package:kater/compute/PostRender.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: "Kater",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostViewPage(
          title: "Kater",
          discussionId:args["discussionId"]
      ),
    );
  }
}

class PostViewPage extends StatefulWidget {
  PostViewPage({Key key, this.title, this.discussionId}) : super(key: key);

  final String title;
  final String discussionId;

  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  PostList _post = new PostList();
  PostList _filteredPosts = new PostList();

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
      for (Post record in post.post) {
        this._post.post.add(record);
        this._filteredPosts.post.add(record);
      }
    });
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: Text(widget.title),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this
          ._filteredPosts
          .post
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Post record) {
    return Card(
      key: ValueKey(record.title),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: appBackgroundColor),
        child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              record.title,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                new Flexible(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                                text: record.authorName,
                                style: TextStyle(color: Colors.black)),
                            maxLines: 3,
                            softWrap: true,
                          )
                        ]))
              ],
            ),
            onTap: () {}),
      ),
    );
  }

  List<Widget> show = new List<Widget>();

  void _incrementCounter() async {
    show.add(Text("123"));
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: _buildBar(context),
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}