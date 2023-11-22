import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_search_dropdown/smart_search_dropdown.dart';

void main() {
  testWidgets('Test SmartSearchDropdown Initialization',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SmartSearchDropdown(
          controller: TextEditingController(),
          items: [
            SmartSearchDropdownItem(value: '1', description: 'Item 1'),
            SmartSearchDropdownItem(value: '2', description: 'Item 2'),
            SmartSearchDropdownItem(value: '3', description: 'Item 3'),
          ],
          selectedItem: '2',
        ),
      ),
    );
    expect(find.byType(SmartSearchDropdown), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('Test SmartSearchDropdown Interaction',
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: SmartSearchDropdown(
          controller: controller,
          items: [
            SmartSearchDropdownItem(value: '1', description: 'Item 1'),
            SmartSearchDropdownItem(value: '2', description: 'Item 2'),
            SmartSearchDropdownItem(value: '3', description: 'Item 3'),
          ],
          selectedItem: '2',
        ),
      ),
    );

    // Tap on the dropdown to open it
    await tester.tap(find.byType(SmartSearchDropdown));
    await tester.pump();

    // Enter text into the search field
    await tester.enterText(find.byType(TextField), 'Item 3');
    await tester.pump();

    // Verify that the search results are correctly displayed
    expect(find.text('Item 3'), findsOneWidget);

    // Tap on the selected item
    await tester.tap(find.text('Item 3'));
    await tester.pump();

    // Verify that the selected item has changed
    expect(controller.text, 'Item 3');
  });
}
