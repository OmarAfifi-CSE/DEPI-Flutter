import 'payment_method.dart';

class WalletPayment extends PaymentMethod {
  final String _phoneNumber;

  WalletPayment({required String phoneNumber}) : _phoneNumber = phoneNumber;

  @override
  void pay(double amount) {
    print('Processing wallet payment of \$$amount');
    print(
      'Payment successful using wallet linked to phone number $_phoneNumber.',
    );
  }

  @override
  String paymentDetails() {
    return 'Wallet Payment: Phone Number: $_phoneNumber';
  }
}
