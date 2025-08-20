import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product.dart';
import '../styling/app_colors.dart';
import '../styling/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(productController),
            const SizedBox(height: 20),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          childAspectRatio: 3 / 4,
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
    return Container(
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
                Consumer<CartController>(
                  builder: (context, cart, child) {
                    bool inCart = cart.isInCart(product);
                    return IconButton(
                      icon: Icon(
                        inCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                        size: 24,
                        color: inCart
                            ? AppColors.blackColor
                            : AppColors.blackColor,
                      ),
                      onPressed: () {
                        inCart
                            ? cart.removeItem(product.id!)
                            : cart.addItem(product);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: inCart
                                ? Text('${product.name} removed from cart')
                                : Text('${product.name} added to cart!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
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
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.subtitlesStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
