class CartItem {
  final String id;
  final String title;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}