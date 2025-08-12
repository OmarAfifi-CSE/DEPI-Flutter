import 'package:uuid/uuid.dart' show Uuid;

class FoodItem {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;
  final double price;

  FoodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.price,
  });
}

var uuid = const Uuid();
final List<FoodItem> foodItems = [
  FoodItem(
    id: uuid.v4(),
    title: 'Burger Combo',
    subtitle: 'Tasty burger with drink',
    imagePath: 'assets/images/item_1.jpg',
    price: 15,
  ),
  FoodItem(
    id: uuid.v4(),
    title: 'Cheese Burger',
    subtitle: 'Delicious burger with fries',
    imagePath: 'assets/images/item_2.jpg',
    price: 12.5,
  ),
  FoodItem(
    id: uuid.v4(),
    title: 'Pizza',
    subtitle: 'Freshly baked pizza',
    imagePath: 'assets/images/item_3.jpg',
    price: 20,
  ),
  FoodItem(
    id: uuid.v4(),
    title: 'Pasta',
    subtitle: 'Tomato pasta with herbs',
    imagePath: 'assets/images/item_4.jpg',
    price: 18,
  ),
];

enum ViewType { list, grid }
