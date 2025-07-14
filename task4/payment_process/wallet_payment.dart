import 'payment_method.dart';

class WalletPayment extends PaymentMethod {
  final String phoneNumber;

  WalletPayment({
    required this.phoneNumber,
  });

  @override
  void pay(double amount) {
    print('Processing wallet payment of \$$amount');
    print('Payment successful using wallet linked to phone number $phoneNumber.');
  }
  @override
  String paymentDetails() {
    return 'Wallet Payment: Phone Number: $phoneNumber';
  }
}