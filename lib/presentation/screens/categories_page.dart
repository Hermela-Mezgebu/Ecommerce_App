import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final String selectedCategory;

  const CategoriesPage({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
      ),
      body: Center(
        child: Text('Category: $selectedCategory'),
      ),
    );
  }
}