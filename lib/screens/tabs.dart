import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/data/dummy_data.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<String, bool> _filters = const {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  late List<Meal> _availableMeals = List<Meal>.from(dummyMeals);

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _applyFilters() {
    _availableMeals = dummyMeals.where((meal) {
      if (_filters['gluten'] == true && !meal.isGlutenFree) return false;
      if (_filters['lactose'] == true && !meal.isLactoseFree) return false;
      if (_filters['vegetarian'] == true && !meal.isVegetarian) return false;
      if (_filters['vegan'] == true && !meal.isVegan) return false;
      return true;
    }).toList();
  }

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = Map<String, bool>.from(filters);
      _applyFilters();
    });
    _showInfoMessage('Filters updated');
  }

  // New function: pushes MealDetailsScreen and waits for result to update UI
  Future<void> _selectMealAndUpdateFavoriteStatus(Meal meal) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: _toggleMealFavoriteStatus,
          isFavorite: _favoriteMeals.contains(meal),
        ),
      ),
    );

    if (result == true) {
      setState(() {
        // Rebuild to update UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      availableMeals: _availableMeals,
      onToggleFavorite: _toggleMealFavoriteStatus,
      favoriteMeals: _favoriteMeals,
      onSelectMeal: _selectMealAndUpdateFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        title: 'Favorites',
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
        favoriteMeals: _favoriteMeals,
        onSelectMeal: _selectMealAndUpdateFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        currentFilters: _filters,
        onSetFilters: _setFilters,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
