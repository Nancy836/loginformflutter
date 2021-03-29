// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebaseauthentification/main.dart';

import '../lib/setup/login.dart';

import '../lib/setup/signup_page.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets("adding input to textfield", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Nancy Umutoni');
    expect(find.text('Nancy Umutoni'), findsOneWidget);
    print('Nancy Umutoni');
  });

  testWidgets("pressing login button", (WidgetTester tester) async {
    await tester.pumpWidget(LogIn());
    // finding widget
    final button = find.byType(ElevatedButton);
    //tapping button
    await tester.tap(button);
    //rebuilding widget
    await tester.pump();
    //expect to find 
    expect(find.text("Text"), findsOneWidget);

  });
  
  testWidgets("pressing signup button", (WidgetTester tester) async {
    await tester.pumpWidget(SignUp());
    // finding widget
    final button = find.byType(ElevatedButton);
    //tapping button
    await tester.tap(button);
    //rebuilding widget
    await tester.pump();
    //expect to find 
    expect(find.text("Text"), findsOneWidget);
  });

}


