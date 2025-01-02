// lib/models/menu.dart
class Menu {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Menu({
    this.id = 0,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.name,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'image': this.image,
    };
  }
}
