// lib/pages/profile_restaurant_page.dart
import 'package:flutter/material.dart';
import 'package:food_finder/models/dummy_data.dart';

import '../components/menu_list_tab.dart';
import '../components/restaurant_form_tab.dart';
import '../models/menu.dart';
import 'menu_form_page.dart';

class ProfileRestaurantPage extends StatefulWidget {
  const ProfileRestaurantPage({super.key});

  @override
  _ProfileRestaurantPageState createState() => _ProfileRestaurantPageState();
}

class _ProfileRestaurantPageState extends State<ProfileRestaurantPage> {
  int _currentIndex = 0;
  final TextEditingController _nameController = TextEditingController(
    text: 'Restoran A',
  );
  final TextEditingController _descriptionController = TextEditingController(
    text: 'Restoran A menyediakan makanan internasional.',
  );
  final TextEditingController _addressController = TextEditingController(
    text: 'Jl. A No. 1',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '081234567890',
  );
  final TextEditingController _websiteController = TextEditingController(
    text: 'https://restorana.com',
  );
  final TextEditingController _latitudeController = TextEditingController(
    text: '-6.2088',
  );
  final TextEditingController _longitudeController = TextEditingController(
    text: '106.8456',
  );

  List<Menu> _menus = dummyMenus;

  void _addMenu(Menu menu) {
    setState(() {
      _menus.add(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Profile'),
          backgroundColor: Colors.blue[900],
          bottom: TabBar(tabs: [Tab(text: 'Profil'), Tab(text: 'Daftar Menu')]),
        ),
        body: TabBarView(
          children: [
            RestaurantFormTab(
              nameController: _nameController,
              descriptionController: _descriptionController,
              addressController: _addressController,
              phoneController: _phoneController,
              websiteController: _websiteController,
              latitudeController: _latitudeController,
              longitudeController: _longitudeController,
            ),
            MenuListTab(menus: _menus, onMenuAdded: _addMenu),
          ],
        ),
        floatingActionButton:
            _currentIndex == 1
                ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddMenuPage(onMenuAdded: _addMenu),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.blue[900],
                )
                : null,
      ),
    );
  }
}
