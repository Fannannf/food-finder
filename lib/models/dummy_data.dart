// lib/models/dummy_data.dart
import 'menu.dart';
import 'restaurant.dart';

List<Restaurant> dummyRestaurants = [
  Restaurant(
    name: 'Restoran A',
    owner: 'John Doe',
    description: 'Restoran A menyediakan makanan internasional.',
    address: 'Jl. A No. 1',
    phone: '081234567890',
    website: 'https://restorana.com',
    latitude: -6.2088,
    longitude: 106.8456,
    image: 'assets/images/resto_default.png',
    // image: 'https://via.placeholder.com/150',
  ),
  Restaurant(
    name: 'Restoran B',
    owner: 'Jane Smith',
    description: 'Restoran B menyediakan makanan lokal.',
    address: 'Jl. B No. 2',
    phone: '081234567891',
    website: 'https://restoranb.com',
    latitude: -6.2089,
    longitude: 106.8457,
    image: 'assets/images/resto_default.png',
  ),
  Restaurant(
    name: 'Restoran C',
    owner: 'Alice Johnson',
    description: 'Restoran C menyediakan makanan khas.',
    address: 'Jl. C No. 3',
    phone: '081234567892',
    website: 'https://restoranc.com',
    latitude: -6.2090,
    longitude: 106.8458,
    image: 'assets/images/resto_default.png',
  ),
  Restaurant(
    name: 'Restoran D',
    owner: 'Bob Brown',
    description: 'Restoran D menyediakan makanan cepat saji.',
    address: 'Jl. D No. 4',
    phone: '081234567893',
    website: 'https://restorand.com',
    latitude: -6.2091,
    longitude: 106.8459,
    image: 'assets/images/resto_default.png',
  ),
  Restaurant(
    name: 'Restoran E',
    owner: 'Charlie Davis',
    description: 'Restoran E menyediakan makanan khas Indonesia.',
    address: 'Jl. E No. 5',
    phone: '081234567894',
    website: 'https://restorane.com',
    latitude: -6.2092,
    longitude: 106.8460,
    image: 'assets/images/resto_default.png',
  ),
];

List<Menu> dummyMenus = [
  Menu(
    name: 'Menu 1',
    description: 'Deskripsi Menu 1',
    price: 25000,
    image: 'assets/images/menu_default.png',
  ),
  Menu(
    name: 'Menu 2',
    description: 'Deskripsi Menu 2',
    price: 30000,
    image: 'assets/images/menu_default.png',
  ),
  // Tambahkan menu lainnya di sini
];
