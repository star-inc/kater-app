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

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        id: json["id"],
        title: json["id"],
        authorName: json["id"],
        authorAvatarUrl:json["id"]);
  }
}

class PostList {
  List<Post> post;

  PostList({this.post});

  factory PostList.load(List<dynamic> parsedJson) {
    List<Post> post = new List<Post>();
    post = parsedJson.map((i) => Post.fromJson(i)).toList();
    return new PostList(
      post: post,
    );
  }
}

class PostService {
  final apiClient = KaterAPI();

  Future<PostList> loadPosts() async {
    final jsonResponse = await apiClient.getDiscussionById("75451");
    PostList post = new PostList.load(jsonResponse["data"]);
    return post;
  }
}
