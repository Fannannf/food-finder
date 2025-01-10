import 'dart:convert';
import 'dart:io';

import 'package:food_finder/helpers/api_driver.dart';
import 'package:food_finder/models/bookmarks_models.dart';
import 'package:food_finder/models/menu.dart';
import 'package:food_finder/models/rating.dart';
import 'package:food_finder/models/restaurant.dart';
import 'package:food_finder/models/review.dart';

class APIServices {
  APIDriver driver = APIDriver();

  Future<Map<String, dynamic>> getProfile() async {
    final response = await driver.get('/profile');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> updateProfile(
    String email,
    String firstName,
    String lastName,
  ) async {
    final response = await driver.put('/profile', {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  }

  Future<void> updatePassword(
    String old_pass,
    String new_pass,
    String confirm,
  ) async {
    final response = await driver.put('/profile/password', {
      'old_password': old_pass,
      'new_password': new_pass,
      'confirmation': confirm,
    });
    if (response.statusCode != 200) {
      throw Exception("Perubahan password gagal");
    }
  }

  Future<Restaurant> addRestaurant(Restaurant resto) async {
    final response = await driver.post('/resto', resto.toJson());
    final savedResto = Restaurant.fromJson(jsonDecode(response.body));
    return savedResto;
  }

  Future<Restaurant> uploadRestoImage(Restaurant resto, File restoImage) async {
    final response =
        await driver.uploadImage('/resto/${resto.id}/image', restoImage);
    return resto;
  }

  Future<Restaurant> updateRestaurant(Restaurant resto) async {
    final response = await driver.put('/resto/${resto.id}', resto.toJson());
    final savedResto = Restaurant.fromJson(jsonDecode(response.body));
    return savedResto;
  }

  Future<List<Restaurant>> getResto() async {
    final response = await driver.get('/resto');
    List<dynamic> listRestoJson = jsonDecode(response.body);
    return listRestoJson.map((value) => Restaurant.fromJson(value)).toList();
  }

  Future<List<Menu>> getMenu(int restoId) async {
    final response = await driver.get('/resto/$restoId/menu');
    List<dynamic> listMenuJson = jsonDecode(response.body);
    return listMenuJson.map((value) => Menu.fromJson(value)).toList();
  }

  Future<Menu> addMenu(Menu menu) async {
    final response =
        await driver.post('/resto/${menu.restoId}/menu', menu.toJson());
    final savedMenu = Menu.fromJson(jsonDecode(response.body));
    return savedMenu;
  }

  Future<Menu> uploadMenuImage(Menu menu, File menuImage) async {
    await driver.uploadImage('/menu/${menu.id}/image', menuImage);
    return menu;
  }

  Future<void> delMenu(int menuId) async {
    final response = await driver.delete('/menu/$menuId');
  }

  Future<Rating> getRating(int menuId) async {
    final response = await driver.get('/resto/$menuId/rating');
    return jsonDecode(response.body);
  }

  Future<List<Review>> getReview(int restoId) async {
    final response = await driver.get('/resto/$restoId/review');
    List<dynamic> listReviewJson = jsonDecode(response.body);
    return listReviewJson.map((value) => Review.fromJson(value)).toList();
  }

  // bookmarks
  Future<Bookmark> addBookmark(Bookmark bookmark) async {
    final response = await driver.post('/bookmark', bookmark.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Bookmark.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add bookmark: ${response.body}');
    }
  }

  Future<List<Bookmark>> getBookmarks() async {
    final response = await driver.get('/bookmark');
    print('Response body: ${response.body}'); // Debug respons API
    if (response.statusCode == 200) {
      List<dynamic> bookmarksJson = jsonDecode(response.body);
      print('Parsed bookmarks: $bookmarksJson'); // Debug parsing JSON
      return bookmarksJson.map((json) => Bookmark.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch bookmarks: ${response.body}');
    }
  }
}
