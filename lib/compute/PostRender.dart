import 'package:kater/compute/API.dart';
import 'package:html/parser.dart' show parse;


class Post {
  String content;
  String authorName;

  Post({
    this.content,
    this.authorName,
  });

  factory Post.fromJson(Map<String, dynamic> json, AuthorList authorList) {
    String _parseHtmlString(String htmlString) {
      var document = parse(htmlString);
      String parsedString = parse(document.body.text).documentElement.text;
      return parsedString;
    }
    return new Post(
        content: _parseHtmlString(
            '${json["attributes"]["contentHtml"]}'),
        authorName: authorList.getUsername(
            '${json["relationships"]["user"]["data"]["id"]}'));
  }
}

class PostList {
  List<Post> post;

  PostList({this.post});

  factory PostList.load(List<dynamic> parsedJson, AuthorList authorList) {
    List<dynamic> jsonPost = new List<dynamic>();
    for (var post in parsedJson) {
      if (post["type"] == "posts") {
        jsonPost.add(post);
      }
    }
    List<Post> post = new List<Post>();
    post = jsonPost.map((i) => Post.fromJson(i, authorList)).toList();
    return new PostList(
      post: post,
    );
  }
}

class AuthorList {
  Map<String, Map> authorList;

  AuthorList({this.authorList});

  factory AuthorList.load(List<dynamic> parsedJson) {
    Map<String, Map> authorList = new Map<String, Map>();
    for (var user in parsedJson) {
      if (user["type"] == "users") {
        authorList[user["id"]] = {
          "username": user["attributes"]["username"],
          "avatarUrl": user["attributes"]["avatarUrl"]
        };
      }
    }
    return new AuthorList(
      authorList: authorList,
    );
  }

  String getUsername(String userId) {
    return authorList[userId]["username"];
  }

  String getAvatarUrl(String userId) {
    return authorList[userId]["avatarUrl"];
  }
}

class PostService {
  final apiClient = KaterAPI();
  Future<PostList> loadPosts(String discussionId) async {
    final jsonResponse = await apiClient.getDiscussionById(discussionId);
    final AuthorList authorList = new AuthorList.load(jsonResponse["included"]);
    PostList post = new PostList.load(jsonResponse["included"], authorList);
    return post;
  }
}
