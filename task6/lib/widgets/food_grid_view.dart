// widgets/food_grid_item.dart

import 'package:flutter/material.dart';
import 'package:task6/models/food_item.dart';
import 'package:task6/widgets/add_to_cart_button.dart';

class FoodGridView extends StatelessWidget {
  final List<FoodItem> _items;

  const FoodGridView({super.key, required List<FoodItem> items})
    : _items = items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 270,
      ),
      itemBuilder: (context, index) {
        final item = _items[index];
        return GridTile(
          header: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item.imagePath, fit: BoxFit.cover, height: 120),
          ),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title),
                Text(item.subtitle, style: TextStyle(color: Colors.grey[500])),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AddToCartButton(),
                ),
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
