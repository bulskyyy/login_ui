import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'lunas':
        return const Color(0xFFDFF6E8); // light green background
      case 'on going':
      case 'ongoing':
        return const Color(0xFFFFF4E0); // light orange
      default:
        return Colors.grey[200]!;
    }
  }

  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'lunas':
        return const Color(0xFF2E7D32);
      case 'on going':
      case 'ongoing':
        return const Color(0xFFB36B00);
      default:
        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // icon
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1E5BAA).withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.receipt_long,
                color: Color(0xFF1E5BAA),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // left column: price + time/table
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rp ${order.amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${order.time}  •  Meja. ${order.table}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          // middle: type
          Expanded(
            flex: 3,
            child: Text(
              order.type.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          // right: payment + status badge
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  order.payment.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _statusTextColor(order.status),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
