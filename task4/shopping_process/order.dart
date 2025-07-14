import '../payment_process/payment_method.dart';
import '../product_catalog/product.dart';

class Order {
  final String orderId;
  final DateTime createdDate;
  final List<Map<Product, int>> items;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.createdDate,
    required this.items,
    required this.totalPrice,
  });

  void Checkout(PaymentMethod paymentMethod) {
    if (items.isEmpty) {
      print('Cannot checkout. Your cart is empty.');
      return;
    }

    print('Processing order with ID: $orderId');
    print('Order created on: $createdDate');
    print('Total price: \$$totalPrice');

    paymentMethod.pay(totalPrice);
    print('Order completed successfully!');
  }
}