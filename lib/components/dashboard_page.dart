// lib/widgets/dashboard_column.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/restaurant_card.dart';

import '../models/dummy_data.dart';
import '../models/restaurant.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Restaurant> _restaurants = dummyRestaurants;
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _restaurants;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredRestaurants =
          _restaurants
              .where(
                (restaurant) =>
                    restaurant.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              labelText: 'Search Restaurant',
              prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[900]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[900]!),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = _filteredRestaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          ),
        ),
      ],
    );
  }
}
