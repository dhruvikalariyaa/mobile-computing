import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meal_provider.dart';

class MealListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);
    provider.loadMeals(); // Consider moving this to a StatefulWidget for better control

    return Scaffold(
      appBar: AppBar(
        title: Text('Meals'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteMealsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              provider.setSearchQuery(value);
            },
            decoration: InputDecoration(
              labelText: 'Search',
            ),
          ),
          Row(
            children: [
              Text('Vegetarian'),
              Checkbox(
                value: provider.isVegFilter,
                onChanged: (value) {
                  provider.setVegFilter(value!);
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.meals.length,
              itemBuilder: (context, index) {
                final meal = provider.meals[index];
                return ListTile(
                  title: Text(meal.title),
                  trailing: IconButton(
                    icon: Icon(
                      provider.favorites.contains(meal) ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () {
                      provider.toggleFavorite(meal);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MealProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Meals'),
      ),
      body: ListView.builder(
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final meal = provider.favorites[index];
          return ListTile(
            title: Text(meal.title),
          );
        },
      ),
    );
  }
}
