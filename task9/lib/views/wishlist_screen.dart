import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:task9/widgets/custom_empty_screen.dart';

import '../controllers/wishlist_controller.dart';
import '../controllers/cart_controller.dart';
import '../model/product.dart';
import '../styling/app_colors.dart';
import '../styling/app_text_styles.dart';
import '../routing/app_routes.dart';
import '../widgets/custom_snackbar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Consumer<WishlistController>(
        builder: (context, wishlistController, child) {
          if (wishlistController.wishlist.isEmpty) {
            return const CustomEmptyScreen(
              screenName: 'Wishlist',
              iconData: Icons.favorite_border,
            );
          }
          return _buildWishlistContent(context, wishlistController);
        },
      ),
    );
  }

  Widget _buildWishlistContent(
    BuildContext context,
    WishlistController wishlistController,
  ) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemCount: wishlistController.wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlistController.wishlist[index];
                return _buildWishlistCard(context, product, wishlistController);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistCard(
    BuildContext context,
    Product product,
    WishlistController wishlistController,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.pushNamed(AppRoutes.itemDetailScreen, extra: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
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
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withValues(alpha: 0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {
                          wishlistController.removeFromWishlist(product);
                          CustomSnackBar.showSnackBar(
                            context: context,
                            message: '${product.name} removed from wishlist',
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Consumer<CartController>(
                      builder: (context, cart, child) {
                        bool inCart = cart.isInCart(product);
                        return Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: inCart ? Colors.blue : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackColor.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              inCart
                                  ? Icons.remove_shopping_cart
                                  : Icons.add_shopping_cart,
                              color: inCart
                                  ? Colors.white
                                  : AppColors.blackColor,
                              size: 20,
                            ),
                            onPressed: () {
                              if (inCart) {
                                cart.removeItem(product.id!);
                                CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: '${product.name} removed from cart',
                                  color: Colors.red,
                                );
                              } else {
                                cart.addItem(product);
                                CustomSnackBar.showSnackBar(
                                  context: context,
                                  message: '${product.name} added to cart!',
                                  color: Colors.green,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.blackTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.category.toUpperCase(),
                        style: AppTextStyles.subtitlesStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
