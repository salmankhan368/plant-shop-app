import 'package:demo_proj/features/data/models/product/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  void addToCart(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.name == product.name,
    );
    if (index != -1) {
      _cartItems[index].qauntity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void decreaseQuantiy(CartItem item) {
    if (item.qauntity > 1) {
      item.qauntity--;
    } else {
      _cartItems.remove(item);
    }
    notifyListeners();
  }

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get itemCount => _cartItems.length;
}

class CartItem {
  final Product product;
  int qauntity;
  CartItem({required this.product, this.qauntity = 1});
  double get totalPrice => product.price * qauntity;
}
