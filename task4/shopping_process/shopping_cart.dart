import '../product_catalog/product.dart';
import '../user_management/customer.dart';

class ShoppingCart {
  final Customer _customer;
  List<Map<Product, int>> _items = [];

  ShoppingCart({required Customer}) : _customer = Customer;

  void addItem(Map<Product, int> item) {
    if (item.isEmpty) {
      print('Item cannot be empty.');
      return;
    } else {
      _items.add(item);
      print('$item added to the cart.');
    }
  }

  void removeItem(String item) {
    if (_items.contains(item)) {
      _items.remove(item);
      print('$item removed from the cart.');
    } else {
      print('$item is not in the cart.');
    }
  }

  double getTotal() {
    double total = 0.0;
    _items.forEach((item) {
      item.forEach((product, quantity) {
        total += product.price * quantity;
      });
    });
    return total;
  }

  void viewCart() {
    if (_items.isEmpty) {
      print('Your cart is empty.');
    } else {
      print('Items in your cart: ${_items.join(', ')}');
    }
  }
}
