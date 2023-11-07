## Usage

Here's how to use the `SmartSearchDropdown` widget in your Flutter app:

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:smart_search_dropdown/smart_search_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Smart Search Dropdown Example'),
        ),
        body: Center(
          child: SmartSearchDropdown(
            controller: TextEditingController(),
            items: [
              CustomDropDownItem(value: '1', description: 'Item 1'),
              CustomDropDownItem(value: '2', description: 'Item 2'),
              CustomDropDownItem(value: '3', description: 'Item 3'),
            ],
            selectedItem: '2',
            onItemSelected: (item) {
              print('Selected item: ${item.description}');
            },
          ),
        ),
      ),
    );
  }
}
