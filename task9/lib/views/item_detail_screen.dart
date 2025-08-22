import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task9/controllers/wishlist_controller.dart';
import 'package:task9/styling/app_text_styles.dart';

import '../controllers/cart_controller.dart';
import '../model/product.dart';
import '../styling/app_colors.dart';

class ItemDetailScreen extends StatelessWidget {
  final Product product;

  const ItemDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(),
                  const SizedBox(height: 24),
                  _buildDescription(),
                  const SizedBox(height: 32),
                  _buildAddToCartSection(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withValues(alpha: 0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: Consumer<WishlistController>(
            builder: (context, wishlist, child) {
              bool inWishlist = wishlist.isInWishlist(product);
              return IconButton(
                icon: Icon(
                  inWishlist ? Icons.favorite : Icons.favorite_border,
                  color: inWishlist ? Colors.red : AppColors.blackColor,
                ),
                onPressed: () {
                  inWishlist
                      ? wishlist.removeFromWishlist(product)
                      : wishlist.addToWishlist(product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            inWishlist
                                ? Icons.remove_circle
                                : Icons.check_circle,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            inWishlist
                                ? '${product.name} removed from wishlist'
                                : '${product.name} added to wishlist!',
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 1),
                      backgroundColor: inWishlist ? Colors.red : Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.blackColor.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            product.category.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product.name,
          style: AppTextStyles.primaryHeadlineStyle.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'In Stock',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ...List.generate(5, (index) {
              if (index < product.rating.floor()) {
                return const Icon(Icons.star, color: Colors.amber, size: 20);
              } else if (index < product.rating) {
                return const Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 20,
                );
              } else {
                return const Icon(
                  Icons.star,
                  color: AppColors.greyColor,
                  size: 20,
                );
              }
            }),
            const SizedBox(width: 8),
            Text(
              '${product.rating} (128 reviews)',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.description,
          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey[700]),
        ),
        const SizedBox(height: 20),
        _buildFeatures(),
      ],
    );
  }

  Widget _buildFeatures() {
    final features = [
      {
        'icon': Icons.local_shipping,
        'title': 'Free Shipping',
        'subtitle': 'On orders over \$50',
      },
      {
        'icon': Icons.refresh,
        'title': 'Easy Returns',
        'subtitle': '30-day return policy',
      },
      {
        'icon': Icons.security,
        'title': 'Secure Payment',
        'subtitle': 'SSL encrypted checkout',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        ...features.map(
          (feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        feature['subtitle'] as String,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartSection(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        bool inCart = cart.isInCart(product);
        final cartItem = cart.items[product.id];

        return Container(
          padding: inCart ? const EdgeInsets.all(20) : EdgeInsets.zero,
          decoration: inCart
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                )
              : null,
          child: Column(
            children: [
              if (inCart) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity in Cart:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: () => cart.updateQuantity(
                            product.id!,
                            cartItem!.quantity - 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${cartItem?.quantity ?? 0}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          icon: Icons.add,
                          onPressed: () => cart.updateQuantity(
                            product.id!,
                            cartItem!.quantity + 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (inCart) {
                      cart.removeItem(product.id!);
                      _showSnackBar(
                        context,
                        '${product.name} removed from cart',
                        Colors.red,
                      );
                    } else {
                      cart.addItem(product);
                      _showSnackBar(
                        context,
                        '${product.name} added to cart!',
                        Colors.green,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: inCart ? Colors.red : Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        inCart
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        inCart ? 'Remove from Cart' : 'Add to Cart',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              color == Colors.green ? Icons.check_circle : Icons.remove_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
