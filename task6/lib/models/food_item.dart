class FoodItem {
  final String title;
  final String subtitle;
  final String imagePath;

  const FoodItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

enum ViewType { list, grid }