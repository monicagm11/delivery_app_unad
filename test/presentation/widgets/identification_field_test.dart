import 'package:delivery_app/domain/entities/identification_data.dart';
import 'package:delivery_app/presentation/widgets/identification_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('IdentificationFormField has default value CC',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IdentificationFormField(),
        ),
      ),
    );
    
    final dropdownFinder = find.byType(DropdownButton<String>);
    final dropdown = tester.widget<DropdownButton<String>>(dropdownFinder);
    
    expect(find.text('Identificación'), findsOneWidget);
    expect(dropdownFinder, findsOneWidget);
    expect(dropdown.value, 'CC');
  });

  testWidgets('IdentificationFormField set initialValue',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IdentificationFormField(initialValue: IdentificationData(code: 'NIT', number: '123456'),),
        ),
      ),
    );

    final dropdownFinder = find.byType(DropdownButton<String>);
    final dropdown = tester.widget<DropdownButton<String>>(dropdownFinder);

    expect(dropdownFinder, findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
    expect(dropdown.value, 'NIT');
  });
}