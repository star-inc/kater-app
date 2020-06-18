import 'package:kater/compute/API.dart';

class Post {
  String id;
  String title;
  String authorName;
  String authorAvatarUrl;

  Post({
    this.id,
    this.title,
    this.authorName,
    this.authorAvatarUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json, AuthorList authorList) {
    final postId = json["id"];
    final postTitle = json["attributes"]["title"];
    final authorId = json["relationships"]["user"]["data"]["id"];
    return new Post(
        id: postId,
        title: postTitle,
        authorName: authorList.getUsername(authorId),
        authorAvatarUrl: authorList.getAvatarUrl(authorId));
  }
}

class PostList {
  List<Post> post;

  PostList({this.post});

  factory PostList.load(List<dynamic> parsedJson, AuthorList authorList) {
    List<Post> post = new List<Post>();
    post = parsedJson.map((i) => Post.fromJson(i, authorList)).toList();
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

  Future<PostList> loadPosts() async {
    final jsonResponse = await apiClient.getNews();
    final AuthorList authorList = new AuthorList.load(jsonResponse["included"]);
    PostList post = new PostList.load(jsonResponse["data"], authorList);
    return post;
  }
}
