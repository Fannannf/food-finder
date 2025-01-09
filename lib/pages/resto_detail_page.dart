// lib/pages/restaurant_detail_page.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/styles.dart';
import 'package:food_finder/helpers/variables.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/menu_list_tab.dart';
import '../models/menu.dart';
import '../models/restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;
  List<Menu> menus = [];

  RestaurantDetailPage({required this.restaurant, required this.menus});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _openGoogleMaps(double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude',
    );

    final Uri googleUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    _launchInBrowser(googleMapUrl);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.restaurant.name,
            style: whiteBoldText,
          ),
          backgroundColor: Colors.blue[900],
          bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              tabs: [Tab(text: 'Menu'), Tab(text: 'Info')]),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.restaurant.image == null
                      ? const AssetImage('assets/images/resto_default.png')
                      : NetworkImage(Variables.url + widget.restaurant.image!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.blue[900]!.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MenuListTab(
                    resto: widget.restaurant,
                    onMenuAdded: (menu) {
                      // Aksi ketika menu baru ditambahkan
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurant.description ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          Text(
                            widget.restaurant.address ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Website:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.restaurant.website != null &&
                                  widget.restaurant.website!.isNotEmpty) {
                                String url = widget.restaurant.website!;
                                if (!url.startsWith('http')) {
                                  url = 'https://$url';
                                }
                                final uri = Uri.parse(url);
                                _launchInBrowser(uri);
                              }
                            },
                            child: Text(
                              widget.restaurant.website ?? 'http://',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[900],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Phone:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                _makePhoneCall(widget.restaurant.phone ?? ''),
                            child: Text(
                              widget.restaurant.phone ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[900],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 100)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openGoogleMaps(
            widget.restaurant.latitude ?? 0,
            widget.restaurant.longitude ?? 0,
          ),
          child: Icon(Icons.map, color: Colors.white),
          backgroundColor: Colors.blue[900],
        ),
      ),
    );
  }
}
