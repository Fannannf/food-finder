class Bookmark {
  final int userId;
  final int restaurantId;

  Bookmark({required this.userId, required this.restaurantId});

  // Konversi Bookmark ke JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'restaurant_id': restaurantId,
    };
  }

  // Buat Bookmark dari JSON
  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      userId: json['user_id'],
      restaurantId: json['restaurant_id'],
    );
  }
}
