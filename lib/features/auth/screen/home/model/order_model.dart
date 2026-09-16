class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}

class OrderModel {
  final String id;
  final String name;
  final String userId;
  final String phone;
  final String address;
  final String paymentMethod;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  final List<OrderItem> items;
  OrderModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.phone,
    required this.address,
    required this.paymentMethod,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.items,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentMethod,
      'status': status,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
