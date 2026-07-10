import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final VoidCallback onSelectedCategory;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedCategory,
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.white24,
      child: Container(
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.8),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          category.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}