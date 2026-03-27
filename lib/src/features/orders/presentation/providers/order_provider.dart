import 'package:flutter/material.dart';
import '../domain/entities/order_entity.dart';
import '../../cart/domain/entities/cart_item.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderEntity> _orders = [];

  List<OrderEntity> get orders => [..._orders];

  void addOrder(List<CartItem> cartItems, double total, String address) {
    final newOrder = OrderEntity(
      id: DateTime.now().toString(),
      items: cartItems,
      totalAmount: total,
      dateTime: DateTime.now(),
      shippingAddress: address,
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
