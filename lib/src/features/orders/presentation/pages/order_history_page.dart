import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../presentation/providers/order_provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orderProvider.orders.isEmpty
          ? const Center(child: Text('You have no orders yet.'))
          : ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text('Order #${order.id.substring(order.id.length - 5)}'),
                    subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(order.dateTime)),
                    trailing: Text('\$${order.totalAmount.toStringAsFixed(2)}', 
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping to: ${order.shippingAddress}'),
                            const SizedBox(height: 10),
                            const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                            ...order.items.map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${item.product.name} x${item.quantity}'),
                                  Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
