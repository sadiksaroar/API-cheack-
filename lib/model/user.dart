class User {
  User({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final num? userId;
  final int? id;
  final String? title;
  final String? body;

  User copyWith({num? userId, int? id, String? title, String? body}) {
    return User(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
