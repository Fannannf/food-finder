class Review {
  final int id;
  User user;
  final int rating;
  final String comment;

  Review(
      {required this.id,
      required this.rating,
      required this.comment,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user: User.fromJson(json['user']),
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'user': this.user,
      'rating': this.rating,
      'comment': this.comment,
    };
  }
}

class User {
  final String username;
  int id;
  User({required this.username, required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
    );
  }
}
