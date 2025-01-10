class Review {
  final int id;
  User user;
  final int rating;
  final String review;

  Review({required this.id, required this.rating, required this.review, required this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user: User.fromJson(json['user']),
      rating: json['rating'] ?? 0,
      review: json['review'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'user': this.user,
      'rating': this.rating,
      'review': this.review,
    };
  }
}

class User {
  final String username;
  User({required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
    );
  }
}
