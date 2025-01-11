// lib/pages/profile_restaurant_page.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/styles.dart';
import 'package:food_finder/helpers/api_services.dart';
import 'package:food_finder/models/dummy_data.dart';
import 'package:food_finder/models/restaurant.dart';
import 'package:food_finder/models/review.dart';

import '../components/menu_list_tab.dart';
import '../components/restaurant_form_tab.dart';
import '../components/widgets.dart';
import '../models/menu.dart';
import 'menu_form_page.dart';

class ProfileRestaurantPage extends StatefulWidget {
  Restaurant? resto;
  List<Review> review = [];
  ProfileRestaurantPage({super.key, this.resto});

  @override
  _ProfileRestaurantPageState createState() => _ProfileRestaurantPageState();
}

class _ProfileRestaurantPageState extends State<ProfileRestaurantPage> {
  int _currentIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _latLongController = TextEditingController();

  List<Menu> _menus = dummyMenus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final curResto = widget.resto;
    if (curResto != null) {
      _nameController.text = curResto.name;
      _descriptionController.text = curResto.description ?? '';
      _addressController.text = curResto.address ?? '';
      _phoneController.text = curResto.phone ?? '';
      _websiteController.text = curResto.website ?? '';
      _latLongController.text =
          "${(curResto.latitude ?? 0)},${(curResto.longitude ?? 0)}";
    }
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    try {
      final reviews = await APIServices().getReview(widget.resto!.id);
      setState(() {
        widget.review = reviews;
      });
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  void _addMenu(Menu menu) {
    setState(() {
      _menus.add(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil Restoran', style: whiteBoldText),
          backgroundColor: Colors.blue[900],
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white54,
            ),
            tabs: [
              Tab(text: 'Profil'),
              Tab(text: 'Daftar Menu'),
              Tab(
                text: "Review",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RestaurantFormTab(
              nameController: _nameController,
              descriptionController: _descriptionController,
              addressController: _addressController,
              phoneController: _phoneController,
              websiteController: _websiteController,
              latLongController: _latLongController,
              resto: widget.resto,
            ),
            MenuListTab(
              resto: widget.resto,
              onMenuAdded: _addMenu,
              canAddMenu: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: widget.review.isNotEmpty
                        ? Column(
                            children: widget.review.map(
                            (review) {
                              return ListTile(
                                leading: Icon(Icons.person),
                                title: Text(review.user.username),
                                subtitle: Text(review.comment),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      review.rating.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.star)
                                  ],
                                ),
                              );
                            },
                          ).toList())
                        : Center(
                            child: Text("Belum ada review"),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuFormPage(
                        onMenuAdded: _addMenu,
                        resto: widget.resto!,
                      ),
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

class NoRestoPage extends StatefulWidget {
  @override
  State<NoRestoPage> createState() => _NoRestoTabState();
}

class _NoRestoTabState extends State<NoRestoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Column(
            children: [
              Text(
                'Anda belum memiliki restoran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              BlueButton(
                text: "Buat Resto Sekarang",
                onPressed: () {
                  Navigator.pushNamed(context, '/profile_restaurant');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
