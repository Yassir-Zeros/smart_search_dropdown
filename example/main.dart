import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_search_dropdown/smart_search_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Search Dropdown Example'),
        ),
        body: Center(
          child: SmartSearchDropdown(
            controller: TextEditingController(),
            items: [
              SmartSearchDropdownItem(value: '1', description: 'Item 1'),
              SmartSearchDropdownItem(value: '2', description: 'Item 2'),
              SmartSearchDropdownItem(value: '3', description: 'Item 3'),
            ],
            selectedItem: '2',
            onItemSelected: (item) {
              if (kDebugMode) {
                print('Selected item: ${item.description}');
              }
            },
          ),
        ),
      ),
    );
  }
}
