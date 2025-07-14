import 'inventory_management/inventory.dart';
import 'payment_process/credit_card_payment.dart';
import 'payment_process/payment_method.dart';
import 'product_catalog/clothing_product.dart';
import 'product_catalog/electronic_product.dart';
import 'product_catalog/product.dart';
import 'shopping_process/order.dart';
import 'shopping_process/shopping_cart.dart';
import 'user_management/admin.dart';
import 'user_management/customer.dart';

void main() {
  print("--- 🏁 Starting E-commerce System Simulation ---");

  // 1. User & Admin Setup
  Admin admin = Admin(
    id: 'admin123',
    email: 'omar.admin@gmail.com',
    password: '123456',
    privileges: ['manage_users', 'view_reports', 'edit_products'],
  );
  print("✅ Admin '${admin.email}' created.");

  Customer customer = Customer(
    id: 'customer456',
    email: 'ali.customer@gmail.com',
    password: '654321',
    shippingAddress:
    '123 Saad Zaghloul St., Minya al-Qamh, Al-Sharqia Governorate, 44621, Egypt',
  );
  print("✅ Customer '${customer.email}' created.");
  print("------------------------------------------");

  // 2. Product Creation
  Product product1 = ElectronicProduct(
    id: 'prod789',
    name: 'Samsung Galaxy S25',
    description: '12 Gb RAM, 256 GB Storage',
    price: 999.99,
    warrantyPeriod: 24,
  );
  Product product2 = ClothingProduct(
    id: 'prod101',
    name: 'Casual T-Shirt',
    description: 'Color: Black',
    price: 19.99,
    availableSizes: ['S', 'M', 'L', 'XL'],
  );
  print("✅ Products '${product1.name}' and '${product2.name}' created.");
  print("------------------------------------------");

  // 3. Inventory Management
  Inventory inventory = Inventory(admin: admin);
  print("✅ Inventory created and assigned to Admin '${admin.email}'.");
  inventory.stock = [
    {product1: 50},
    {product2: 100},
  ];
  print("📦 Initial stock set: ${inventory.stock[0].values} x '${product1.name}', ${inventory.stock[1].values} x '${product2.name}'.");
  print("------------------------------------------");

  // 4. Shopping Process
  ShoppingCart shoppingCart = ShoppingCart(customer: customer, inventory: inventory);
  print("🛒 Shopping cart created for Customer '${customer.email}'.");
  print("🛍️ Adding items to the cart...");
  shoppingCart.addItem({product1: 1});
  print("------------------------------------------");

  // 5. Order and Payment
  print("📄 Initializing order...");
  Order order = Order(
    orderId: 'order001',
    createdDate: DateTime.now(),
    items: shoppingCart.items,
    totalPrice: shoppingCart.getTotal(),
  );
  print("✅ Order 'order001' created with a total of \$${order.totalPrice.toStringAsFixed(2)}.");

  PaymentMethod paymentMethod = CreditCardPayment(
    cardNumber: '1234-5678-9012-3456',
    expiryDate: DateTime(2028, 7),
    cvv: '123',
  );
  print("💳 Credit Card payment method prepared.");

  print("\n--- ▶️ Initiating Checkout Process ---");
  order.Checkout(paymentMethod);
  print("--- 🎉 Checkout Process Complete ---");
}