import '../../cart/domain/entities/cart_item.dart';

class OrderEntity {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;
  final String shippingAddress;

  const OrderEntity({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
    required this.shippingAddress,
  });
}
