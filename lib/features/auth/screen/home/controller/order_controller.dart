import 'package:demo_proj/features/auth/screen/home/model/order_model.dart';
import 'package:demo_proj/features/auth/screen/home/repository/order_repository.dart';
import 'package:flutter/foundation.dart';

class OrderController extends ChangeNotifier {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository);

  bool isLoading = false;
  String? errorMessage;

  List<OrderModel> orders = [];

  Future<void> createOrder(OrderModel order) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _orderRepository.createOrder(order);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      return await _orderRepository.getOrders();
    } catch (e) {
      errorMessage = e.toString();
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
