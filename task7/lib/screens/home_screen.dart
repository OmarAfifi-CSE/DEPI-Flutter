import 'package:flutter/material.dart';
import 'package:task7/models/food_item.dart';
import 'package:task7/widgets/carousel_widget.dart';
import 'package:task7/widgets/food_grid_view.dart';
import 'package:task7/widgets/food_list_view.dart';
import 'package:task7/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback goToCart;

  const HomeScreen({super.key, required this.goToCart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ViewType _currentView = ViewType.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Food Delivery',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: widget.goToCart,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchField(),
              const SizedBox(height: 20),
              const CarouselWidget(),
              const Text(
                'Featured Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildToggleButton('List View', ViewType.list),
                  const SizedBox(width: 10),
                  _buildToggleButton('Grid View', ViewType.grid),
                ],
              ),
              const SizedBox(height: 20),
              if (_currentView == ViewType.list)
                FoodListView(items: foodItems, goToCart: widget.goToCart)
              else
                FoodGridView(items: foodItems, goToCart: widget.goToCart),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, ViewType viewType) {
    final bool isActive = _currentView == viewType;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _currentView = viewType;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.red : null,
          foregroundColor: isActive ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(text),
      ),
    );
  }
}
