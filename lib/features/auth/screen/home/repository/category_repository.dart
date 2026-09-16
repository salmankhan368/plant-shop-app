import 'package:demo_proj/features/auth/screen/home/model/categoy_model.dart';
import 'package:demo_proj/features/auth/screen/home/services/category_service.dart';

class CategoryRepository {
  final CategoryService _service;
  CategoryRepository(this._service);
  Future<List<CategoryModel>> getCategory() => _service.fetchCategory();
}
