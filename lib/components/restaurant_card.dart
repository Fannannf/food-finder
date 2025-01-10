import 'package:flutter/material.dart';
import 'package:food_finder/helpers/api_services.dart';
import 'package:food_finder/helpers/variables.dart';
import 'package:food_finder/models/bookmarks_models.dart';
import 'package:food_finder/models/dummy_data.dart';
// import 'package:food_finder/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/menu.dart';
import '../models/restaurant.dart';
import '../pages/resto_detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  // final int userId; // Tambahkan userId sebagai parameter

  final List<Menu> menus = dummyMenus;

  RestaurantCard({required this.restaurant});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  void _showBookmarkDialog(BuildContext context) {
    final apiServices = APIServices();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Konfirmasi Bookmark'),
          content: Text(
              'Apakah Anda yakin ingin menambahkan restoran ini ke bookmark?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext); // Tutup dialog

                try {
                  // Panggil fungsi addBookmark
                  await apiServices.addBookmark(
                    Bookmark(
                      userId: restaurant.owner ?? 0,
                      restaurantId: restaurant.id,
                    ),
                  );

                  // Tampilkan snackbar sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bookmark berhasil ditambahkan!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Tampilkan snackbar error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menambahkan bookmark: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailPage(
                restaurant: restaurant,
                menus: menus,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: restaurant.image != null
                  ? Image.network(
                      Variables.url + restaurant.image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/resto_default.png',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          restaurant.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _makePhoneCall(restaurant.phone ?? ''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Icon(Icons.phone, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _showBookmarkDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Icon(Icons.bookmark, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
