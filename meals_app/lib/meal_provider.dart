import 'package:flutter/material.dart';
import 'meal.dart';
import 'meal_service.dart';

class MealProvider with ChangeNotifier {
  List<Meal> _meals = [];
  List<Meal> _favorites = [];
  bool _isVegFilter = false;
  String _searchQuery = '';

  List<Meal> get meals {
    return _meals.where((meal) {
      final matchesQuery = meal.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesVeg = !_isVegFilter || meal.isVegetarian;
      return matchesQuery && matchesVeg;
    }).toList();
  }

  List<Meal> get favorites => _favorites;

  bool get isVegFilter => _isVegFilter;

  Future<void> loadMeals() async {
    _meals = await MealService().fetchMeals();
    notifyListeners();
  }

  void toggleFavorite(Meal meal) {
    if (_favorites.contains(meal)) {
      _favorites.remove(meal);
    } else {
      _favorites.add(meal);
    }
    notifyListeners();
  }

  void setVegFilter(bool value) {
    _isVegFilter = value;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
