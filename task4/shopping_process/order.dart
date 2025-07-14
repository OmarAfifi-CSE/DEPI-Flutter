import '../payment_process/credit_card_payment.dart';
import '../payment_process/payment_method.dart';
import '../payment_process/wallet_payment.dart';
import '../product_catalog/product.dart';
import 'phone_number_validator.dart';

class Order {
  final String _orderId;
  DateTime _createdDate;
  List<Map<Product, int>> _items;
  double _totalPrice;

  Order({
    required String orderId,
    required DateTime createdDate,
    required List<Map<Product, int>> items,
    required double totalPrice,
  }) : _orderId = orderId,
       _createdDate = createdDate,
       _items = items,
       _totalPrice = totalPrice;

  // Getters and Setters
  String get orderId => _orderId;
  DateTime get createdDate => _createdDate;
  List<Map<Product, int>> get items => _items;
  double get totalPrice => _totalPrice;
  set createdDate(DateTime date) {
    _createdDate = date;
  }
  set items(List<Map<Product, int>> newItems) {
    _items = newItems;
  }
  set totalPrice(double price) {
    _totalPrice = price;
  }

  void Checkout(PaymentMethod paymentMethod) {
    if (_items.isEmpty) {
      print('Cannot checkout. Your cart is empty.');
      return;
    }

    if (paymentMethod is CreditCardPayment) {
      if (DateTime.now().isAfter(paymentMethod.expiryDate)) {
        print('❌Checkout Failed: Credit card is expired in ${paymentMethod.expiryDate.month}/${paymentMethod.expiryDate.year}.\n');
        return;
      }
    } else if (paymentMethod is WalletPayment) {
      if (!paymentMethod.phoneNumber.isEgyptianPhoneNumber) {
        print(
          '❌Checkout Failed: "${paymentMethod.phoneNumber}" is invalid egyptian phone number for wallet payment.\n',
        );
        return;
      }
    }

    print('Processing order with ID: $_orderId');
    print('Order created on: $_createdDate');
    print('Total price: \$$_totalPrice');

    paymentMethod.pay(_totalPrice);
    print('Order completed successfully!');
    print('--- 🎉 Checkout Process Complete ---\n');
  }
}
