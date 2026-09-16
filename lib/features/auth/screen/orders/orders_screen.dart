import 'package:demo_proj/features/auth/screen/home/controller/order_controller.dart';
import 'package:demo_proj/features/auth/screen/home/model/order_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final controller = context.read<OrderController>();

    final result = await controller.getOrders();

    if (mounted) {
      setState(() {
        orders = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.errorMessage != null
          ? Center(
              child: Text(
                controller.errorMessage!,
                textAlign: TextAlign.center,
              ),
            )
          : orders.isEmpty
          ? const Center(
              child: Text('No orders yet', style: TextStyle(fontSize: 16)),
            )
          : RefreshIndicator(
              onRefresh: _fetchOrders,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return _orderCard(order);
                },
              ),
            ),
    );
  }

  Widget _orderCard(OrderModel order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id.substring(0, 6)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                _statusBadge(order.status),
              ],
            ),

            const SizedBox(height: 10),

            // Date
            Text(
              'Date: ${_formatDate(order.createdAt)}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),

            const SizedBox(height: 8),

            Text(
              'Items: ${order.items.length}',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 6),

            Text(
              'Payment: ${order.paymentMethod == 'cod' ? 'Cash on Delivery' : 'Card'}',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//statusbadge
Widget _statusBadge(String status) {
  Color color;

  switch (status.toLowerCase()) {
    case 'delivered':
      color = Colors.green;
      break;

    case 'cancelled':
      color = Colors.red;
      break;

    case 'confirmed':
      color = Colors.blue;
      break;

    case 'processing':
      color = Colors.purple;
      break;

    default:
      color = Colors.orange;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      status.toUpperCase(),
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
    ),
  );
}

//formate date
String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
