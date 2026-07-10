import 'package:flutter/material.dart';

class DietModel {
  final String name;
  final String iconPath;
  final String level;
  final String duration;
  final String calorie;
  final Color boxColor;

  const DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
  });

  static List<DietModel> getDiets() {
    return const [
      DietModel(
        name: 'Honey Pancake',
        iconPath: 'assets/images/honey-pancake.jpg',
        level: 'Easy',
        duration: '30mins',
        calorie: '180kcal',
        boxColor: Color(0xff92A3FD),
      ),
      DietModel(
        name: 'Canai Bread',
        iconPath: 'assets/images/canai-bread.jpg',
        level: 'Medium',
        duration: '45mins',
        calorie: '230kcal',
        boxColor: Color(0xffC58BF2),
      ),
    ];
  }
}
