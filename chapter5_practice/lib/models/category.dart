import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String imageUrl;
  final Color color;
  final String foodName;
  final String rating;
  final String description;

  const Category({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.foodName,
    required this.rating,
    required this.description,
  });

  static List<Category> getAllCategories() {
    return [
      Category(
        id: 'c1',
        title: 'Italian',
        imageUrl: 'assets/images/italian.jpg',
        color: Colors.purple,
        foodName: 'Spaghetti',
        rating: '4.6',
        description:
            'Spaghetti is a traditional Italian dish made with pasta, tomato sauce, herbs, and sometimes meat or seafood. It is one of the most popular Italian foods around the world.',
      ),
      Category(
        id: 'c2',
        title: 'French',
        imageUrl: 'assets/images/french.jpg',
        color: Colors.amber,
        foodName: 'Croissant',
        rating: '4.5',
        description:
            'French food is famous for its delicate taste, rich ingredients, and beautiful presentation. Croissants, desserts, and cheese are common examples of French cuisine.',
      ),
      Category(
        id: 'c3',
        title: 'Chinese',
        imageUrl: 'assets/images/chinese.jpg',
        color: Colors.lightBlue,
        foodName: 'Fried Rice',
        rating: '4.7',
        description:
            'Chinese cuisine has many regional styles and uses different cooking methods such as stir-frying, steaming, and boiling. It is known for its rich flavor and variety.',
      ),
      Category(
        id: 'c4',
        title: 'Indian',
        imageUrl: 'assets/images/indian.jpg',
        color: Colors.green,
        foodName: 'Curry',
        rating: '4.4',
        description:
            'Indian food is well known for spices, curry, and strong flavors. Many dishes use ingredients such as turmeric, cumin, chili, and coriander.',
      ),
      Category(
        id: 'c5',
        title: 'Korean',
        imageUrl: 'assets/images/korean.jpg',
        color: Colors.pink,
        foodName: 'Kimchi',
        rating: '4.3',
        description:
            'Korean cuisine often includes rice, vegetables, soup, grilled meat, and fermented food such as kimchi. It is popular for its spicy and savory taste.',
      ),
      Category(
        id: 'c6',
        title: 'Mexican',
        imageUrl: 'assets/images/mexican.jpg',
        color: Colors.teal,
        foodName: 'Taco',
        rating: '4.5',
        description:
            'Mexican food is colorful and flavorful. Common ingredients include corn, beans, chili, tomato, avocado, and cheese.',
      ),
    ];
  }
}