// lib/widgets/restaurant_form_tab.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_finder/components/styles.dart';
import 'package:food_finder/components/widgets.dart';
import 'package:food_finder/helpers/location_service.dart';
import 'package:food_finder/models/restaurant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantFormTab extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController websiteController;
  final TextEditingController latLongController;

  Restaurant? resto;

  RestaurantFormTab({
    required this.nameController,
    required this.descriptionController,
    required this.addressController,
    required this.phoneController,
    required this.websiteController,
    required this.latLongController,
    this.resto,
  });

  @override
  _RestaurantFormTabState createState() => _RestaurantFormTabState();
}

class _RestaurantFormTabState extends State<RestaurantFormTab> {
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  final LocationService _loc = LocationService();
  Position? currentPos;

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _loc.getCurrentLocation();
      setState(() {
        currentPos = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(_image!.path),
                    width: 350,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
                : Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Camera', style: whiteBoldText),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Gallery', style: whiteBoldText),
                ),
              ],
            ),
            SizedBox(height: 20),
            BoxedTextField(
              label: "Nama menu",
              icon: Icons.restaurant,
              controller: widget.nameController,
            ),
            SizedBox(height: 10),
            TextField(
              controller: widget.descriptionController,
              maxLines: 3,
              decoration: boxedInputDecoration("Deskripsi", Icons.description),
            ),
            SizedBox(height: 10),
            BoxedTextField(
              label: "Alamat",
              icon: Icons.location_city,
              controller: widget.addressController,
            ),
            SizedBox(height: 10),
            BoxedTextField(
              label: "No. Telepon",
              icon: Icons.phone,
              controller: widget.phoneController,
            ),
            SizedBox(height: 10),
            BoxedTextField(
              label: "Website",
              icon: Icons.web,
              controller: widget.websiteController,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: boxedInputDecoration(
                      "Lat / Long",
                      Icons.location_pin,
                    ),
                    readOnly: true,
                    controller: widget.latLongController,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _getCurrentLocation().then((value) {
                      widget.latLongController.text =
                          "${currentPos!.latitude},${currentPos!.longitude}";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(Icons.map, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            BlueButton(
              text: "Simpan Profil",
              onPressed: () {
                // Aksi ketika tombol save ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Restaurant profile saved successfully'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
