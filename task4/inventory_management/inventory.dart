import '../product_catalog/product.dart';
import '../user_management/admin.dart';

class Inventory {
  final Admin _admin;
  List<Map<Product, int>> _stock = [];

  Inventory({required Admin admin}) : _admin = admin;
  Admin get admin => _admin;
  List<Map<Product, int>> get stock => _stock;
  set stock(List<Map<Product, int>> newStock) {
    _stock = newStock;
  }

  void addProduct(Product product, int quantity) {
    if (quantity <= 0) {
      print('Quantity must be greater than zero.');
      return;
    }

    // Check if the product exists
    final index = _stock.indexWhere((item) => item.containsKey(product));
    if (index != -1) {
      _stock[index].update(
        product,
        (existingQuantity) => existingQuantity + quantity,
        ifAbsent: () => quantity,
      );
      print(
        "$quantity unit of '$product' added. New total: ${_stock[index][product]}.",
      );
    } else {
      _stock.add({product: quantity});
      print("$quantity unit of '$product' added to stock.");
    }
  }

  bool stockAvailableCheck(Product product, int quantity) {
    final itemMap = _stock.firstWhere(
      (item) => item.containsKey(product),
      orElse: () => {},
    );
    if (itemMap.isEmpty) {
      return false;
    }

    final availableQuantity = itemMap[product] ?? 0;
    return availableQuantity >= quantity;
  }

  void updateStock(Product product, int quantity) {
    if (!stockAvailableCheck(product, quantity)) {
      throw Exception(
        'Failed to update stock: Not enough quantity for $product. Required: $quantity',
      );
    }
    final index = _stock.indexWhere((item) => item.containsKey(product));
    _stock[index][product] = _stock[index][product]! - quantity;
    print(
      "Stock updated successfully, New product quantity: ${_stock[index][product]}.",
    );
  }
}
