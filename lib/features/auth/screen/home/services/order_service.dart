import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_proj/features/auth/screen/home/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //this code only save our code in firstore
  Future<void> createOrder(OrderModel order) async {
    try {
      await _firestore.collection('orders').doc(order.id).set(order.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //and this code fetch it
  Future<List<OrderModel>> getOrders() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        return OrderModel(
          id: doc.id,
          name: data['name'] ?? '',
          userId: data['userId'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
          paymentMethod: data['paymentMethod'] ?? 'cod',
          status: data['status'] ?? 'pending',
          totalPrice: (data['totalPrice'] ?? 0).toDouble(),
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          items: (data['items'] as List<dynamic>? ?? []).map((item) {
            return OrderItem(
              productId: item['productId'] ?? '',
              productName: item['productName'] ?? '',
              quantity: item['quantity'] ?? 0,
              price: (item['price'] ?? 0).toDouble(),
            );
          }).toList(),
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
