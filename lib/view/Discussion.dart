import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:kater/Constants.dart';
import 'package:kater/compute/API.dart';
import 'package:kater/compute/PostRender.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() {
    return _PostPageState();
  }
}

class _PostPageState extends State<PostPage> {

  final String title = appTitle;

  String subject = "";
  String discussionId = "";

  PostList _post = new PostList();

  List<Widget> show = new List<Widget>();

  RefreshController _refreshController =
  new RefreshController(initialRefresh: true);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _post.post.clear();
    _getPosts();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadNoData();
  }

  @override
  void initState() {
    super.initState();
    _post.post = new List();
  }

  void _getPosts() async {
    PostList post = await PostService().loadPosts(this.discussionId);
    setState(() {
      for (Post record in post.post) {
        this._post.post.add(record);
      }
    });
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: Text(this.title),
      leading: new BackButton());
  }

  Widget _buildList(BuildContext context) {
    final apiClient = KaterAPI();
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    this.discussionId = args["discussionId"];
    apiClient.getDiscussionById(this.discussionId).then((data) {
      this.subject = '${data["data"]["attributes"]["title"]}';});
    List<Widget> widgetList = this._post.post.map(
            (data) => _buildListItem(context, data)).toList();
    widgetList.insert(0, Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 13.5),
      child: new Text(this.subject, style: TextStyle(
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          fontSize: 20))
    ));
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: widgetList,
    );
  }

  Widget _buildListItem(BuildContext context, Post record) {
    return Card(
      key: ValueKey(record.content),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: appBackgroundColor),
        child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              record.content,
              style:TextStyle(color: Colors.black),
            ),
            subtitle: Row(
              children: <Widget>[
                new Flexible(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                                text: 'Author: ${record.authorName}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            switch(mode){
              case LoadStatus.idle:
                body = Text("Checking...");
                break;
              case LoadStatus.loading:
                body = Text("Loading...");
                break;
              case  LoadStatus.failed:
                body = Text("Load Failed! Try Again?");
                break;
              case LoadStatus.canLoading:
                body = Text("Release for loading...");
                break;
              default:
                body = Text("No more Data.");
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}