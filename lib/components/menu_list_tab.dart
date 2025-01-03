// lib/widgets/menu_list_tab.dart
import 'package:flutter/material.dart';
import 'package:food_finder/components/widgets.dart';
import 'package:food_finder/helpers/api_services.dart';
import 'package:food_finder/helpers/variables.dart';
import 'package:food_finder/models/restaurant.dart';

import '../models/menu.dart';
import '../pages/menu_form_page.dart';

class MenuListTab extends StatefulWidget {
  final Restaurant? resto;
  final bool canAddMenu;
  List<Menu> menus = [];
  final Function(Menu) onMenuAdded;

  MenuListTab(
      {super.key,
      this.resto,
      required this.onMenuAdded,
      this.canAddMenu = false});

  @override
  State<MenuListTab> createState() => _MenuListTabState();
}

class _MenuListTabState extends State<MenuListTab> {
  APIServices api = APIServices();

  void getMenu() async {
    if (widget.resto != null && widget.resto!.id > 0) {
      api.getMenu(widget.resto!.id).then((menus) {
        setState(() {
          widget.menus = menus;
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMenu();
  }

  void _addMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuFormPage(
          onMenuAdded: widget.onMenuAdded,
          resto: widget.resto!,
        ),
      ),
    );
  }

  void _deleteMenu(Menu menu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi hapus'),
          content: Text('Yakin hapus menu: ${menu.name}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                await api.delMenu(menu.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.menus.length,
              itemBuilder: (context, index) {
                final menu = widget.menus[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: menu.image == null
                              ? Image.asset(
                                  'assets/images/menu_default.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  Variables.url + menu.image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                menu.description ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue[900],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: Rp ${menu.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.canAddMenu)
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _deleteMenu(menu),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          widget.canAddMenu
              ? BlueButton(
                  text: "Tambah Menu",
                  onPressed: () {
                    _addMenu(context);
                  })
              : const SizedBox(height: 20)
        ],
      ),
    );
  }
}
