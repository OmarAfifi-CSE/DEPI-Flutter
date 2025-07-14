import 'payment_method.dart';

class CreditCardPayment extends PaymentMethod {
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  CreditCardPayment({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  @override
  void pay(double amount) {
    print('Processing credit card payment of \$$amount');
    print(
      'Payment successful for using card ending in ${cardNumber.substring(cardNumber.length - 4)}.',
    );
  }

  @override
  String paymentDetails() {
    return 'Credit Card Payment: Card ending in ${cardNumber.substring(cardNumber.length - 4)}, Expiry: $expiryDate';
  }
}
