import 'package:flutter/material.dart';
import 'package:task6/models/food_item.dart';

import 'add_to_cart_button.dart';

class FoodListView extends StatelessWidget {
  final List<FoodItem> _items;
  final Function(FoodItem) onAddToCart;

  const FoodListView({super.key, required List<FoodItem> items, required this.onAddToCart})
    : _items = items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item.imagePath, width: 80,height: 80, fit: BoxFit.cover),
          ),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
          trailing: AddToCartButton(onPressed: () => onAddToCart(item)),
        );
      },
    );
  }
}
