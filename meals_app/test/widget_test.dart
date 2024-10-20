import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/meal_provider.dart';

void main() {
  testWidgets('Meals App: Load meals and toggle favorites', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MealProvider(),
        child: MyApp(),
      ),
    );

    // Verify that the app starts with the title.
    expect(find.text('Meals'), findsOneWidget);

    // Load meals by triggering the loadMeals function
    final provider = Provider.of<MealProvider>(tester.element(find.byType(MealListScreen)), listen: false);
    await provider.loadMeals();
    await tester.pumpAndSettle();

    // Verify that the meals are loaded by checking for one of the meal titles.
    expect(find.text('Veg Pasta'), findsOneWidget);
    expect(find.text('Chicken Curry'), findsOneWidget);

    // Search for a meal.
    await tester.enterText(find.byType(TextField), 'Veg Pasta');
    await tester.pumpAndSettle();

    // Verify that the search returns the correct meal.
    expect(find.text('Veg Pasta'), findsOneWidget);
    expect(find.text('Chicken Curry'), findsNothing);

    // Toggle the favorite status of a meal.
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    // Verify that the meal is now in favorites.
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Navigate to the Favorite Meals screen.
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();

    // Verify that the favorite meal is displayed on the favorites screen.
    expect(find.text('Veg Pasta'), findsOneWidget);
  });
}
