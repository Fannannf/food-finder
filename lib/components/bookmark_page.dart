import 'package:flutter/material.dart';
import 'package:food_finder/helpers/api_services.dart';

import '../models/bookmarks_models.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final APIServices apiServices = APIServices();

  // Future untuk mengambil daftar bookmark
  Future<List<Bookmark>> _fetchBookmarks() async {
    try {
      return await apiServices.getBookmarks();
    } catch (e) {
      throw Exception('Failed to load bookmarks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Bookmark>>(
        future:
            _fetchBookmarks(), // Memanggil fungsi untuk mendapatkan data bookmark
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No data found');
            return Center(
              child: Text(
                "No bookmarks yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final bookmarks = snapshot.data!;
          print('Fetched bookmarks: $bookmarks'); // Debug data yang diterima
          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Restaurant ID: ${bookmark.restaurantId}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('User ID: ${bookmark.userId}'),
                  trailing: Icon(Icons.bookmark, color: Colors.blue),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
