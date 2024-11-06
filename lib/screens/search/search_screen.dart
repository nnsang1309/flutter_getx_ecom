import 'package:flutter/material.dart';

import '../../components/bottom_nav_bar.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Search'),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
