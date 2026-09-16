import 'package:demo_proj/features/ai/screen/ai_screen.dart';
import 'package:demo_proj/features/auth/screen/home/controller/category_controller.dart';
import 'package:demo_proj/features/auth/screen/home/controller/home_controller.dart';
import 'package:demo_proj/features/auth/screen/home/widget/category_card.dart';
import 'package:demo_proj/features/auth/screen/home/widget/shimmer_category.dart';
import 'package:demo_proj/features/auth/screen/home/widget/shimmer_grid.dart';
import 'package:demo_proj/features/auth/screen/profile/profile_page.dart';

import 'package:demo_proj/features/auth/screen/detailScreen/product.detail.Screen.dart';
import 'package:demo_proj/features/auth/screen/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<HomeController>().fetchProducts();
      context.read<CategoryController>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    final categoryController = context.watch<CategoryController>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: const Text(
          'Search Products',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      context.read<HomeController>().searchProducts(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Plants',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.tune),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 105,
              child: categoryController.isLoading
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ShimmerCategoryCard();
                      },
                    )
                  : ListView.builder(
                      itemCount: categoryController.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categoryController.categories[index];

                        return CategoryCard(
                          category: category,
                          isSelected:
                              homeController.selectedCategoryId == category.id,
                          ontap: () {
                            homeController.selectCategory(category.id);
                          },
                        );
                      },
                    ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Found\n ${homeController.filteredProducts.length} Results',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (homeController.isLoading) {
                    return const Center(child: ShimmerGrid());
                  }

                  if (homeController.errorMessage != null) {
                    return Center(child: Text(homeController.errorMessage!));
                  }

                  if (homeController.filteredProducts.isEmpty) {
                    return const Center(child: Text("No Products Found"));
                  }

                  return MasonryGridView.count(
                    itemCount: homeController.filteredProducts.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,

                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,

                    itemBuilder: (context, index) {
                      final product = homeController.filteredProducts[index];

                      return Padding(
                        padding: EdgeInsets.only(top: index.isEven ? 70 : 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: ProductCard(
                            imageUrl: product.imageUrl,
                            name: product.name,
                            price: product.price,
                            onFavourteTap: () {},
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      //floating
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AiScreen()),
          );
        },
        child: const Icon(Icons.smart_toy_outlined),
      ),
    );
  }
}
