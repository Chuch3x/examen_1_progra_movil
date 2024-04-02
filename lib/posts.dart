class Posts {
  final int id;
  final int userId;
  final String title;
  final String body;
  final int rating;

  Posts(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.rating});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'], rating: 3,
    );
  }
}
