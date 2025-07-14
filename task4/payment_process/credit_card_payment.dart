import 'payment_method.dart';

class CreditCardPayment extends PaymentMethod {
  final String _cardNumber;
  final DateTime _expiryDate;
  final String _cvv;
  DateTime get expiryDate => _expiryDate;

  CreditCardPayment({
    required String cardNumber,
    required DateTime expiryDate,
    required String cvv,
  }) : _cardNumber = cardNumber,
       _expiryDate = expiryDate,
       _cvv = cvv;

  @override
  void pay(double amount) {
    print('Processing credit card payment of \$$amount');
    print(
      'Payment successful for using card ending in ${_cardNumber.substring(_cardNumber.length - 4)}.',
    );
  }

  @override
  String paymentDetails() {
    return 'Credit Card Payment: Card ending in ${_cardNumber.substring(_cardNumber.length - 4)}, Expiry: $_expiryDate';
  }
}
