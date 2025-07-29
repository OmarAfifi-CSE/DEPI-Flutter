class FoodItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final double price;

  const FoodItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.price,
  });
}

enum ViewType { list, grid }