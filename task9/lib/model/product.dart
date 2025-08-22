class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;
  final bool isInCart;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
    this.isInCart = false,
  });
}
