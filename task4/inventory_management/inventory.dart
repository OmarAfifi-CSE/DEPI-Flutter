import '../product_catalog/product.dart';
import '../user_management/admin.dart';

class Inventory {
  final Admin _admin;
  final Map<Product, int> _stock = {};

  Inventory({required Admin admin}) : _admin = admin;
  Admin get admin => _admin;
  Map<Product, int> get stock => _stock;

  void addProduct(Product product, int quantity) {
    if (quantity <= 0) {
      print('Quantity must be greater than zero.');
      return;
    }
    _stock.update(
      product,
      (currentQuantity) => currentQuantity + quantity,
      ifAbsent: () => quantity,
    );
    print("$quantity unit of '$product' added. New total: ${_stock[product]}.");
  }

  bool stockAvailableCheck(Product product, int quantity) {
    final availableQuantity = _stock[product] ?? 0;
    return availableQuantity >= quantity;
  }

  void updateStock(Product product, int quantity) {
    if (!stockAvailableCheck(product, quantity)) {
      throw Exception(
        'Failed to update stock: Not enough quantity for $product. Available: ${_stock[product] ?? 0}, Required: $quantity',
      );
    }
    _stock[product] = _stock[product]! - quantity;
    print(
      "Stock updated successfully, New product quantity: ${_stock[product]}.",
    );
  }
}
