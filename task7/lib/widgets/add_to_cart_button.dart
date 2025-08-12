import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task7/provider/cart_provider.dart';

import '../models/food_item.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FoodItem foodItem;

  const AddToCartButton({
    super.key,
    required this.onPressed,
    required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 0,
      ),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Text(
            cartProvider.isItemInCart(foodItem)
                ? 'Remove from cart'
                : 'Add to Cart',
            style: const TextStyle(fontSize: 12),
          );
        },
      ),
    );
  }
}
