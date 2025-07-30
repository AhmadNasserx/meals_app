import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.currentFilters,
    required this.onSetFilters,
  });

  final Map<String, bool> currentFilters;
  final void Function(Map<String, bool> filters) onSetFilters;

  static const Color customDarkBrown = Color.fromARGB(255, 131, 57, 0);
  static const Color customLightBrown = Color.fromARGB(255, 180, 90, 10);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    void selectMeals() {
      if (ModalRoute.of(context)?.settings.name == '/') {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/');
      }
    }

    Future<void> selectFilters() async {
      // Close the drawer first
      Navigator.of(context).pop();

      // Only open filters if not already on the filters screen
      if (ModalRoute.of(context)?.settings.name != FilterScreen.routeName) {
        final result = await Navigator.of(context).pushNamed(
          FilterScreen.routeName,
          arguments: currentFilters,
        );

        if (result is Map<String, bool>) {
          onSetFilters(result);
        }
      }
    }

    return Drawer(
      backgroundColor: colorScheme.surfaceVariant,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [customDarkBrown, customLightBrown],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.fastfood, size: 48, color: Colors.white),
                const SizedBox(width: 18),
                Text(
                  'Cooking Up!',
                  style: textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant, color: colorScheme.onSurface),
            title: Text('Meals', style: textTheme.bodyLarge),
            onTap: selectMeals,
          ),
          ListTile(
            leading: Icon(Icons.settings, color: colorScheme.onSurface),
            title: Text('Filters', style: textTheme.bodyLarge),
            onTap: selectFilters,
          ),
        ],
      ),
    );
  }
}
