class Rating {
  final int rating;

  Rating({required this.rating});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rating: json['rating'] ?? 0,
    );
  }
}
