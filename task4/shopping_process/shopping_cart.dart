import '../inventory_management/inventory.dart';
import '../product_catalog/product.dart';
import '../user_management/customer.dart';

class ShoppingCart {
  final Customer _customer;
  final Inventory _inventory;
  List<Map<Product, int>> _items = [];
  // Getters
  List<Map<Product, int>> get items => _items;
  Customer get customer => _customer;
  Inventory get inventory => _inventory;

  ShoppingCart({required Customer customer, required Inventory inventory})
    : _customer = customer,
      _inventory = inventory;

  void addItem(Map<Product, int> item) {
    if (item.isEmpty) {
      print('Item cannot be empty.');
      return;
    }
    // Extract the product and quantity from the map
    final product = item.keys.first;
    final quantity = item.values.first;

    // Check for availability at the inventory
    if (_inventory.stockAvailableCheck(product, quantity)) {
      _items.add(item);
      print("Success: $item added to the cart.");
    } else {
      print("Failed: Not enough stock for $product to add to cart.");
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
