import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
    required this.favoriteMeals,
    required this.onSelectMeal,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favoriteMeals;
  final void Function(Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    final whiteColor = Colors.white;

    Widget content;

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing here',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: whiteColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: whiteColor),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (context, meal) => onSelectMeal(meal),
          isFavorite: favoriteMeals.contains(meals[index]),
          onToggleFavorite: onToggleFavorite,
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: whiteColor),
        ),
      ),
      body: content,
    );
  }
}
