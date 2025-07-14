import 'product.dart';

class ElectronicProduct extends Product {
  int _warrantyPeriod; // in months

  ElectronicProduct({
    required String id,
    required String name,
    required double price,
    required String description,
    required int warrantyPeriod,
  }) : _warrantyPeriod = warrantyPeriod,
       super(id: id, name: name, price: price, description: description);
  int get warrantyPeriod => _warrantyPeriod;
  set warrantyPeriod(int warrantyPeriod) => _warrantyPeriod = warrantyPeriod;

  @override
  String productDetailsFormat() {
    return 'ElectronicProduct{id: $id, name: $name, price: $price, description: $description, warrantyPeriod: $_warrantyPeriod months}';
  }
}