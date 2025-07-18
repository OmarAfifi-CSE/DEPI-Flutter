import 'product.dart';

class ClothingProduct extends Product {
  List<String> _availableSizes;

  ClothingProduct({
    required String id,
    required String name,
    required double price,
    required String description,
    List<String> availableSizes = const [],
  }) : _availableSizes = availableSizes,
        super(id: id, name: name, price: price, description: description);
  // Getter and Setter
  List<String> get availableSizes => _availableSizes;
  set availableSizes(List<String> availableSizes) => _availableSizes = availableSizes;

  @override
  productDetailsFormat() {
    return 'ClothingProduct{id: $id, name: $name, price: $price, description: $description, availableSizes: ${_availableSizes?.join(', ')}}';
  }

}