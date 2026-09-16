import 'package:demo_proj/features/auth/screen/home/model/product_model.dart';
import 'package:demo_proj/features/auth/screen/home/repository/product_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final ProductRepository repository;
  HomeController(this.repository);
  List<ProductModel> products = [];
  bool isLoading = false;
  String? errorMessage;
  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      errorMessage = null;
      products = await repository.getProducts();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Search
  String searchQuery = '';

  // Selected category
  String? selectedCategoryId;

  // Search + Category filtering
  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final matchesCategory =
          selectedCategoryId == null ||
          product.categoryId == selectedCategoryId;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Search products
  void searchProducts(String query) {
    searchQuery = query;
    notifyListeners();
  }

  // Select category
  void selectCategory(String? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }
}
