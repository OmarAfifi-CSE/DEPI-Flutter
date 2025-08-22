import 'package:flutter/material.dart';

import '../model/product.dart';

class WishlistController extends ChangeNotifier {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  void addToWishlist(Product product) {
    if (!_wishlist.contains(product)) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.remove(product);
    notifyListeners();
  }

  bool isInWishlist(Product product) {
    return _wishlist.contains(product);
  }
}
