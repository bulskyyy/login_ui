class Order {
  final String id;
  final DateTime date;
  final String time;
  final String table;
  final String type;
  final String payment;
  final double amount;
  final String status;

  Order({
    required this.id,
    required this.date,
    required this.time,
    required this.table,
    required this.type,
    required this.payment,
    required this.amount,
    required this.status,
  });
}
