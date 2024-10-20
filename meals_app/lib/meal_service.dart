import 'dart:convert';
import 'package:flutter/services.dart';
import 'meal.dart';

class MealService {
  Future<List<Meal>> fetchMeals() async {
    final String response = await rootBundle.loadString('assets/meals.json');
    final List<dynamic> data = json.decode(response);
    return data.map((meal) => Meal.fromJson(meal)).toList();
  }
}
