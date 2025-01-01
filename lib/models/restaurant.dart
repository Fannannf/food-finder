// lib/models/restaurant.dart
class Restaurant {
  final String name;
  final String owner;
  final String description;
  final String address;
  final String phone;
  final String website;
  final double latitude;
  final double longitude;
  final String image;

  Restaurant({
    required this.name,
    required this.owner,
    required this.description,
    required this.address,
    required this.phone,
    required this.website,
    required this.latitude,
    required this.longitude,
    required this.image,
  });
}
