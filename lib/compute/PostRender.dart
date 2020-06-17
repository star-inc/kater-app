import 'package:kater/compute/API.dart';

class Post {
  String title;
  String authorName;

  Post({
    this.title,
    this.authorName,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        title: json["id"],
        authorName: json["id"]);
  }
}

class PostList {
  List<Post> post;

  PostList({this.post});

  factory PostList.load(Map<String, dynamic> parsedJson) {
    List<Post> post = new List<Post>();
    post.add(Post(
        title: parsedJson["attributes"]["title"],
        authorName: '${parsedJson["relationships"]["posts"]["data"]}')
    );
    return new PostList(
      post: post,
    );
  }
}

class PostService {
  final apiClient = KaterAPI();
  Future<PostList> loadPosts(String discussionId) async {
    final jsonResponse = await apiClient.getDiscussionById(discussionId);
    PostList post = new PostList.load(jsonResponse["data"]);
    return post;
  }
}
