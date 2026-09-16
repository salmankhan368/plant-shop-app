import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_proj/features/auth/screen/home/model/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return ProductModel.fromJson({'id': doc.id, ...doc.data()});
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
