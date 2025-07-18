import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: whiteColor,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: whiteColor,
                  ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            meals[index].title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: whiteColor,
                ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: whiteColor,
              ),
        ),
      ),
      body: content,
    );
  }
}
