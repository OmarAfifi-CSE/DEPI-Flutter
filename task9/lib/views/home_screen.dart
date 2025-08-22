import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:task9/controllers/wishlist_controller.dart';

import '../controllers/product_controller.dart';
import '../model/product.dart';
import '../styling/app_colors.dart';
import '../styling/app_text_styles.dart';
import '../routing/app_routes.dart';
import '../widgets/custom_snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(productController),
            const SizedBox(height: 12),
            _buildFilterTabs(context, productController),
            const SizedBox(height: 20),
            _buildProductGrid(productController),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ProductController controller) {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: AppTextStyles.hintTextStyle,
        prefixIcon: const Icon(Icons.search, color: AppColors.secondaryColor),
        filled: true,
        fillColor: AppColors.greyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context, ProductController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTab('All', context, controller),
        const SizedBox(width: 10),
        _buildTab('Featured', context, controller),
        const SizedBox(width: 10),
        _buildTab('New', context, controller),
      ],
    );
  }

  Widget _buildTab(
    String title,
    BuildContext context,
    ProductController controller,
  ) {
    final isSelected = controller.selectedTab == title;
    return GestureDetector(
      onTap: () => controller.updateSelectedTab(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : AppColors.greyColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(ProductController controller) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 6 / 8,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return _buildProductCard(product, context);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.itemDetailScreen, extra: product);
      },
      child: Container(
        decoration: const BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Consumer<WishlistController>(
                    builder: (context, wishlist, child) {
                      bool inWishlist = wishlist.isInWishlist(product);
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withValues(
                                alpha: 0.1,
                              ),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            inWishlist
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            size: 22,
                            color: inWishlist
                                ? Colors.red
                                : AppColors.blackColor,
                          ),
                          onPressed: () {
                            inWishlist
                                ? wishlist.removeFromWishlist(product)
                                : wishlist.addToWishlist(product);
                            CustomSnackBar.showSnackBar(
                              context: context,
                              message: inWishlist
                                  ? '${product.name} removed from wishlist!'
                                  : '${product.name} added to wishlist!',
                              color: inWishlist ? Colors.red : Colors.green,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.blackTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.subtitlesStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
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
          ],
        ),
      ),
    );
  }
}
