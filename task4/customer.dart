import 'user.dart';

class Customer extends User {
  String _shippingAddress;

  Customer({
    required String id,
    required String email,
    required String password,
    required String shippingAddress,
  }) : _shippingAddress = shippingAddress,
        super(id: id, email: email, password: password);

  String get shippingAddress => _shippingAddress;
  set shippingAddress(String shippingAddress) => _shippingAddress = shippingAddress;

  @override
  String toString() {
    return 'Customer{id: $id, email: $email, password: $password, shippingAddress: $_shippingAddress}';
  }
}
