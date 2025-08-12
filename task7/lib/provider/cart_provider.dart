import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get subtotal => cartItems.fold(
    0,
    (total, current) => total + (current.price * current.quantity),
  );

  double get deliveryFee => 5.00;

  double get taxes => subtotal * 0.10;

  double get total => subtotal + deliveryFee + taxes;

  int get itemCount => _cartItems.length;

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addToCart(FoodItem foodItem) {
    for (var item in _cartItems) {
      if (item.id == foodItem.id) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    _cartItems.add(
      CartItem(
        id: foodItem.id,
        title: foodItem.title,
        imagePath: foodItem.imagePath,
        price: foodItem.price,
      ),
    );
    notifyListeners();
  }

  void incrementCartItem(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementCartItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cartItems.remove(item);
    }
    notifyListeners();
  }

  bool isItemInCart(FoodItem foodItem) {
    return _cartItems.any((item) => item.id == foodItem.id);
  }

  void removeFromCart(FoodItem item) {
    _cartItems.removeWhere((cartItem) => cartItem.id == item.id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void toggleAddToCartButton(
    FoodItem item,
    BuildContext context,
    VoidCallback onViewCart,
  ) {
    final bool itemIsInCart = isItemInCart(item);
    itemIsInCart ? removeFromCart(item) : addToCart(item);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      itemIsInCart
          ? SnackBar(
              content: Text('\'${item.title}\' removed from cart'),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red,
            )
          : SnackBar(
              content: Text('\'${item.title}\' added to cart'),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'VIEW',
                textColor: Colors.white,
                onPressed: onViewCart,
              ),
            ),
    );
  }
}
