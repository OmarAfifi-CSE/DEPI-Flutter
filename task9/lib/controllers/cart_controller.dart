import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/cart_item.dart';
import '../model/product.dart';

class CartController extends ChangeNotifier {
  final Map<String?, CartItem> _items = {};

  Map<String?, CartItem> get items => _items;

  double get subtotal => _items.values.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  double get taxes => subtotal * 0.1; // 10% taxes
  double get total => subtotal + taxes;

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(product.id, () => CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (_items.containsKey(productId)) {
      if (newQuantity > 0) {
        _items.update(
          productId,
          (existingItem) =>
              CartItem(product: existingItem.product, quantity: newQuantity),
        );
      } else {
        removeItem(productId);
      }
      notifyListeners();
    }
  }

  bool isInCart(Product product) {
    return _items.containsKey(product.id);
  }
}
