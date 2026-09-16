import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_proj/features/auth/screen/home/model/categoy_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      return snapshot.docs.map((doc) {
        return CategoryModel.fromJson({'id': doc.id, ...doc.data()});
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
