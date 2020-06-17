class Record {
  String title;
  String avatarUrl;
  Record({
    this.title,
    this.avatarUrl,
  });
  factory Record.fromJson(Map<String, dynamic> json){
    return new Record(
        title: json["attributes"]["title"],
        avatarUrl: ""
    );
  }
}