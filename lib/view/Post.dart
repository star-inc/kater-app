import 'package:flutter/material.dart';

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
          postId:args["postId"]
      ),
    );
  }
}

class PostViewPage extends StatefulWidget {
  PostViewPage({Key key, this.title, this.postId}) : super(key: key);

  final String title;
  final String postId;

  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  List<Widget> show = new List<Widget>();
  void _incrementCounter() async {
    show.add(Text("123"));
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Text(widget.postId),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: show
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
