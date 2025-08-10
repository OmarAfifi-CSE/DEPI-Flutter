import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cartProvider.itemCount,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
                      return _buildCartItemTile(item, context);
                    },
                  ),
                ),
                _buildCheckoutSection(context),
              ],
            ),
    );
  }

  Widget _buildCartItemTile(CartItem item, BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          item.imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        '\$${item.price.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Consumer<CartProvider>(
        builder: (context, cartProvider, child) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (item.quantity == 1) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('\'${item.title}\' removed from cart'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green.shade800,
                    ),
                  );
                }
                cartProvider.decrementCartItem(item);
              },
            ),
          ),
          Text(
            item.quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.add),
              onPressed: () => cartProvider.incrementCartItem(item),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildCheckoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) =>
         Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPriceRow(
              'Subtotal:',
              '\$${cartProvider.subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),
            _buildPriceRow(
              'Delivery Fee:',
              '\$${cartProvider.deliveryFee.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 12),
            _buildPriceRow(
              'Taxes:',
              '\$${cartProvider.taxes.toStringAsFixed(2)}',
            ),
            const Divider(height: 32),
            _buildPriceRow(
              'Total:',
              '\$${cartProvider.total.toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Checkout', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String title, String amount, {bool isTotal = false}) {
    final style = TextStyle(
      fontSize: isTotal ? 20 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style),
        Text(amount, style: style),
      ],
    );
  }
}
