import 'package:flutter/material.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habesha Mart'),
      ),
      body: const Center(
        child: Text('Home Page - Coming Next'),
      ),
    );
  }
}