import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meal_provider.dart';
import 'meal_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MealProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MealListScreen(),
    );
  }
}
