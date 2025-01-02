import 'dart:convert';

import 'package:food_finder/helpers/api_driver.dart';

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
}
