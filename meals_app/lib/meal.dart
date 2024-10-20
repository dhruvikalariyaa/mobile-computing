class Meal {
  final String id;
  final String title;
  final bool isVegetarian;

  Meal({required this.id, required this.title, required this.isVegetarian});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      title: json['title'],
      isVegetarian: json['isVegetarian'],
    );
  }
}
