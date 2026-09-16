import 'package:demo_proj/features/auth/screen/home/model/order_model.dart';
import 'package:demo_proj/features/auth/screen/home/services/order_service.dart';

class OrderRepository {
  final OrderService _orderService;

  OrderRepository(this._orderService);

  Future<void> createOrder(OrderModel order) async {
    await _orderService.createOrder(order);
  }

  Future<List<OrderModel>> getOrders() async {
    return await _orderService.getOrders();
  }
}
