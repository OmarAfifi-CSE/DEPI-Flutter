import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task7/models/food_item.dart';

import '../provider/cart_provider.dart';
import 'add_to_cart_button.dart';

class FoodListView extends StatelessWidget {
  final List<FoodItem> _items;
  final VoidCallback goToCart;

  const FoodListView({super.key, required List<FoodItem> items, required this.goToCart})
    : _items = items;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
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
          trailing: AddToCartButton(onPressed: () {
            cartProvider.addToCart(item);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('\'${item.title}\' added to cart'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: 'VIEW',
                  textColor: Colors.white,
                  onPressed: () {
                    goToCart();
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
