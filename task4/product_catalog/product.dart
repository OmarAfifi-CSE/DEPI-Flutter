abstract class Product{
  final String _id;
  String _name;
  double _price;
  String _description;
  String productDetailsFormat();

  Product({
    required String id,
    required String name,
    required double price,
    required String description,
  }): _id = id,
        _name = name,
        _price = price,
        _description = description;
  // Getters and Setters
  String get id => _id;
  String get name => _name;
  double get price => _price;
  String get description => _description;
  set name(String name) => _name = name;
  set price(double price) => _price = price;
  set description(String description) => _description = description;
  @override
  String toString() {
    return 'Product{id: $_id, name: $_name, price: $_price, description: $_description}';
  }
}