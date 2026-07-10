import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widgets/category_grid_item.dart';
import 'details_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void selectFoodCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Category.getAllCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Food Category',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 8 / 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in categories)
            CategoryGridItem(
              category: category,
              onSelectedCategory: () {
                selectFoodCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}