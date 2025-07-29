import 'package:flutter/material.dart';
import 'package:task6/models/food_item.dart';
import 'package:task6/widgets/carousel_widget.dart';
import 'package:task6/widgets/food_grid_view.dart';
import 'package:task6/widgets/food_list_view.dart';
import 'package:task6/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  final Function(FoodItem) onAddToCart;
  const HomeScreen({super.key, required this.onAddToCart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ViewType _currentView = ViewType.list;
  final List<FoodItem> _items = [
    const FoodItem(
      title: 'Burger Combo',
      subtitle: 'Tasty burger with drink',
      imagePath: 'assets/images/item_1.jpg',
      price: 15,
    ),
    const FoodItem(
      title: 'Cheese Burger',
      subtitle: 'Delicious burger with fries',
      imagePath: 'assets/images/item_2.jpg',
      price: 12.5,
    ),
    const FoodItem(
      title: 'Pizza',
      subtitle: 'Freshly baked pizza',
      imagePath: 'assets/images/item_3.jpg',
      price: 20,
    ),
    const FoodItem(
      title: 'Pasta',
      subtitle: 'Tomato pasta with herbs',
      imagePath: 'assets/images/item_4.jpg',
      price: 18,
    ),
  ];

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
            onPressed: () {},
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
                FoodListView(items: _items,onAddToCart: widget.onAddToCart,)
              else
                FoodGridView(items: _items, onAddToCart: widget.onAddToCart,),
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
