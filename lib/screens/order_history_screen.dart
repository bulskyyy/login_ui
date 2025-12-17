import 'package:flutter/material.dart';
import '../models/order.dart';
import 'order_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _showMockData = false;

  List<Order> _mockOrders() {
    final today = DateTime(2025, 8, 28);
    final yesterday = DateTime(2025, 8, 27);
    return [
      Order(
        id: '1',
        date: today,
        time: '11:30',
        table: '12',
        type: 'Dine In',
        payment: 'Tunai',
        amount: 32000,
        status: 'Lunas',
      ),
      Order(
        id: '2',
        date: today,
        time: '11:30',
        table: '12',
        type: 'Takeaway',
        payment: 'Non-Tunai',
        amount: 32000,
        status: 'On Going',
      ),
      Order(
        id: '3',
        date: today,
        time: '11:30',
        table: '12',
        type: 'Dine In',
        payment: 'Tunai',
        amount: 32000,
        status: 'Lunas',
      ),
      Order(
        id: '4',
        date: today,
        time: '11:30',
        table: '12',
        type: 'Dine In',
        payment: 'Tunai',
        amount: 37000,
        status: 'Lunas',
      ),
      Order(
        id: '5',
        date: yesterday,
        time: '11:30',
        table: '12',
        type: 'Takeaway',
        payment: 'Tunai',
        amount: 32000,
        status: 'Lunas',
      ),
    ];
  }

  String _formatDate(DateTime d) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    final days = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];
    final dayName = days[d.weekday % 7];
    return '$dayName, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final orders = _mockOrders();
    final Map<String, List<Order>> grouped = {};
    for (var o in orders) {
      final key = _formatDate(o.date);
      grouped.putIfAbsent(key, () => []).add(o);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          // Sidebar kiri - sesuai home screen
          Container(
            width: 80,
            color: const Color(0xFF1E5BAA),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Online Status
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.wifi, color: Colors.white, size: 24),
                      SizedBox(height: 3),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                
                // Menu Icons
                _buildSidebarIcon(Icons.grid_view, false),
                _buildSidebarIcon(Icons.table_restaurant, false),
                _buildSidebarIcon(Icons.receipt_long, true), // Riwayat Pesanan
                _buildSidebarIcon(Icons.settings, false),
                
                const Spacer(),
                
                // Notes Button - Catatan
                InkWell(
                  onTap: () {
                    print('✅ CATATAN DIKLIK!');
                    Navigator.pushNamed(context, '/notes');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.note_alt,
                          color: Color(0xFFFFD700),
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Catatan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Date & Time di bawah
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        TimeOfDay.now().hour.toString().padLeft(2, '0') +
                            ':' +
                            TimeOfDay.now().minute.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '23\nAug\n2025',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // main content
          Expanded(
            child: Column(
              children: [
                // top header
                Container(
                  width: double.infinity,
                  height: 64,
                  color: const Color(0xFF1E5BAA),
                  child: const Center(
                    child: Text(
                      'Riwayat Pesanan',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // content body
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // tabs
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
                          ),
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  indicatorColor: const Color(0xFF1E5BAA),
                                  labelColor: const Color(0xFF1E5BAA),
                                  unselectedLabelColor: Colors.black87,
                                  tabs: const [
                                    Tab(text: 'Semua Transaksi'),
                                    Tab(text: 'Transaksi Offline'),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 16,
                                  child: Container(color: const Color(0xFF1E5BAA).withOpacity(0.08)),
                                ),
                                SizedBox(
                                  height: 520,
                                  child: TabBarView(
                                    children: [
                                      // Tab 1: Semua Transaksi
                                      _showMockData
                                          ? ListView(
                                              padding: const EdgeInsets.all(16),
                                              children: grouped.entries.map((entry) {
                                                final date = entry.key;
                                                final items = entry.value;
                                                final total = items.fold<double>(0, (p, e) => p + e.amount);
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                          Text('Rp ${total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    ...items.map((o) => OrderItem(order: o)).toList(),
                                                    const SizedBox(height: 18),
                                                  ],
                                                );
                                              }).toList(),
                                            )
                                          : Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.inbox,
                                                    size: 100,
                                                    color: Colors.grey[300],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Belum Ada Riwayat Pesanan',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Mulai buat pesanan Anda sekarang',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      setState(() {
                                                        _showMockData = !_showMockData;
                                                      });
                                                    },
                                                    icon: Icon(_showMockData ? Icons.visibility_off : Icons.visibility),
                                                    label: Text(_showMockData ? 'Sembunyikan Data' : 'Tampilkan Data Demo'),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFF1E5BAA),
                                                      foregroundColor: Colors.white,
                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                      // Tab 2: Transaksi Offline
                                      _showMockData
                                          ? ListView(
                                              padding: const EdgeInsets.all(16),
                                              children: grouped.entries
                                                  .expand((entry) => entry.value
                                                      .where((o) => o.payment.toLowerCase().contains('tunai'))
                                                      .map((o) => OrderItem(order: o)))
                                                  .toList(),
                                            )
                                          : Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.inbox,
                                                    size: 100,
                                                    color: Colors.grey[300],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Belum Ada Transaksi Offline',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Transaksi dengan pembayaran Tunai akan muncul di sini',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      setState(() {
                                                        _showMockData = !_showMockData;
                                                      });
                                                    },
                                                    icon: Icon(_showMockData ? Icons.visibility_off : Icons.visibility),
                                                    label: Text(_showMockData ? 'Sembunyikan Data' : 'Tampilkan Data Demo'),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFF1E5BAA),
                                                      foregroundColor: Colors.white,
                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSidebarIcon(IconData icon, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          // Handle navigation
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: isActive ? Colors.yellow : Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
