import 'package:demo_proj/features/auth/screen/home/model/product_model.dart';
import 'package:demo_proj/features/auth/screen/home/services/firestore_services.dart';

class ProductRepository {
  final FirestoreService _firestoreService;
  ProductRepository(this._firestoreService);
  Future<List<ProductModel>> getProducts() async {
    return await _firestoreService.getProducts();
  }
}
