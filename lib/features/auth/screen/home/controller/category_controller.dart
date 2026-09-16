import 'package:demo_proj/features/auth/screen/home/model/categoy_model.dart';
import 'package:demo_proj/features/auth/screen/home/repository/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryController(this._repository);

  List<CategoryModel> categories = [];

  bool isLoading = false;
  String? errorMessage;
  CategoryModel? selectedCategory;

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      categories = await _repository.getCategory();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //selected category
  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }

  void clearCategory(CategoryModel category) {
    selectedCategory = null;
    notifyListeners();
  }
}
