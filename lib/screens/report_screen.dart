import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String activeSubMenu = 'kas-harian';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Row(
        children: [
          // Sidebar Laporan
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: const Text(
                    'Laporan',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                // Menu Items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildReportMenuItem(
                        icon: Icons.calendar_today,
                        title: 'Kas harian',
                        subtitle: 'Rekap kas harian',
                        menuId: 'kas-harian',
                      ),
                      _buildReportMenuItem(
                        icon: Icons.monetization_on_outlined,
                        title: 'Rekap penjualan',
                        subtitle: 'Monitoring uang penjualan',
                        menuId: 'rekap-penjualan',
                      ),
                      _buildReportMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'Terlaris',
                        subtitle: 'Ringkasan produk terlaris',
                        menuId: 'terlaris',
                      ),
                      _buildReportMenuItem(
                        icon: Icons.description_outlined,
                        title: 'Ringkasan',
                        subtitle: 'Kelola pendapatan',
                        menuId: 'ringkasan',
                      ),
                      _buildReportMenuItem(
                        icon: Icons.inventory_2_outlined,
                        title: 'Inventori',
                        subtitle: 'Informasi barang & stok',
                        menuId: 'inventori',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: _buildReportContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String menuId,
  }) {
    final isActive = activeSubMenu == menuId;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() => activeSubMenu = menuId);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue.shade100 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isActive ? Colors.blue.shade700 : Colors.grey.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isActive ? Colors.blue.shade700 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportContent() {
    switch (activeSubMenu) {
      case 'kas-harian':
        return _buildKasHarian();
      case 'rekap-penjualan':
        return _buildRekapPenjualan();
      case 'terlaris':
        return _buildTerlaris();
      case 'ringkasan':
        return _buildRingkasan();
      case 'inventori':
        return _buildInventori();
      default:
        return _buildComingSoon();
    }
  }

  Widget _buildKasHarian() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rekap Kas',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),

          // Saldo Awal
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo awal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Saldo awal (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Simpan saldo awal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Tambah Pengeluaran
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tambah pengeluaran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Jumlah pengeluaran (Rp)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Tambah keterangan (Optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Tambah pengeluaran',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Ringkasan Kas Harian
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan kas harian',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildKasSummaryRow('Saldo awal:', 'Rp 0'),
                _buildKasSummaryRow('Pengeluaran:', 'Rp 0'),
                _buildKasSummaryRow('Penjualan tunai:', 'Rp 0'),
                const Divider(height: 32, thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Saldo akhir:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp 0',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKasSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildRekapPenjualan() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rekap Penjualan',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),

        // Transaksi Penjualan
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaksi penjualan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              _buildRekapRow('Tunai', '10x', 'Rp 120.000'),
              const SizedBox(height: 16),
              _buildRekapRow('QRIS', '12x', 'Rp 138.000'),
              const SizedBox(height: 16),
              _buildRekapRow('Kartu Debit', '12x', 'Rp 138.000'),
              const Divider(height: 32, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total transaksi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp 376.000',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Penerimaan di Kasir
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Penerimaan di kasir',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              _buildRekapRow('Tunai', '10x', 'Rp 120.000'),
              const SizedBox(height: 16),
              _buildRekapRow('Non - Tunai', '24x', 'Rp 276.000'),
              const Divider(height: 32, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total perimaan di kasir',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp 376.000',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Total
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Penerimaan sistem',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(Total kas + Total transaksi penjualan)',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const Text(
                    'Rp 120.000',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selisih total',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(Total penerimaan di kasir - Penerimaan di sistem)',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const Text(
                    '-Rp 275.000',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget untuk baris rekap
Widget _buildRekapRow(String label, String quantity, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 2,
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      Expanded(
        child: Text(
          quantity,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      Expanded(
        child: Text(
          amount,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

  Widget _buildTerlaris() {
  final topProducts = [
    {'name': 'Ayam Goreng Dada', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Ayam Goreng Dada', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Ayam Goreng Dada', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Ayam Goreng Dada', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Nasi Goreng Special', 'revenue': 'Rp 95.000', 'sold': 'Terjual 8x'},
    {'name': 'Mie Ayam', 'revenue': 'Rp 85.000', 'sold': 'Terjual 7x'},
  ];

  final topCategories = [
    {'name': 'Makanan', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Minuman', 'revenue': 'Rp 120.000', 'sold': 'Terjual 12x'},
    {'name': 'Snack', 'revenue': 'Rp 85.000', 'sold': 'Terjual 8x'},
    {'name': 'Dessert', 'revenue': 'Rp 65.000', 'sold': 'Terjual 6x'},
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Terlaris',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),

        // Produk Terlaris
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Produk terlaris',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              ...topProducts.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> product = entry.value;
                bool isLast = index == topProducts.length - 1;
                
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          product['name']!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product['revenue']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product['sold']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Kategori Terlaris
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kategori terlaris',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              ...topCategories.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> category = entry.value;
                bool isLast = index == topCategories.length - 1;
                
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          category['name']!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            category['revenue']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category['sold']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildRingkasan() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ringkasan',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),

        // Top Section - Chart and Donut
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistik Penjualan - Left Side
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Area Chart
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rp 320.000',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(top: 4),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomPaint(
                            size: const Size(double.infinity, 200),
                            painter: AreaChartPainter(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Statistik penjualan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 32, thickness: 1),
                    const Text(
                      '29 Agustus 2025: Rp 320.000',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Total Pendapatan - Right Side
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(280, 280),
                            painter: DonutChartPainter(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Pendapatan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Rp 320.000',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Pendapatan: Rp 320.000',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Ringkasan Detail
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ringkasan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32, thickness: 1),
              
              // Grid Layout
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 24,
                children: [
                  _buildRingkasanItem('Penjualan kotor', 'Rp 1.918.000'),
                  _buildRingkasanItem('Penjualan bersih', 'Rp 1.918.000'),
                  _buildRingkasanItem('Laba kotor', 'Rp 1.918.000'),
                  _buildRingkasanItem('Laba bersih', 'Rp 1.918.000'),
                  _buildRingkasanItem('Total transaksi', 'Rp 1.918.000'),
                  _buildRingkasanItem('Marjin laba kotor', 'Rp 1.918.000'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRingkasanItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

  Widget _buildInventori() {
  final inventoryItems = [
    InventoryItem(
      name: 'Ayam Goreng',
      category: 'Makanan',
      stock: 45,
      minStock: 20,
      unit: 'porsi',
      price: 15000,
      status: 'Aman',
    ),
    InventoryItem(
      name: 'Nasi Putih',
      category: 'Makanan',
      stock: 12,
      minStock: 20,
      unit: 'porsi',
      price: 5000,
      status: 'Stok Rendah',
    ),
    InventoryItem(
      name: 'Es Teh Manis',
      category: 'Minuman',
      stock: 78,
      minStock: 30,
      unit: 'gelas',
      price: 5000,
      status: 'Aman',
    ),
    InventoryItem(
      name: 'Kopi Hitam',
      category: 'Minuman',
      stock: 5,
      minStock: 15,
      unit: 'cup',
      price: 8000,
      status: 'Stok Kritis',
    ),
    InventoryItem(
      name: 'Pisang Goreng',
      category: 'Snack',
      stock: 25,
      minStock: 10,
      unit: 'porsi',
      price: 8000,
      status: 'Aman',
    ),
    InventoryItem(
      name: 'Kentang Goreng',
      category: 'Snack',
      stock: 8,
      minStock: 15,
      unit: 'porsi',
      price: 12000,
      status: 'Stok Rendah',
    ),
  ];

  // Hitung summary
  int totalItems = inventoryItems.length;
  int lowStock = inventoryItems.where((item) => item.status == 'Stok Rendah').length;
  int criticalStock = inventoryItems.where((item) => item.status == 'Stok Kritis').length;
  int totalValue = inventoryItems.fold(0, (sum, item) => sum + (item.stock * item.price));

  return SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Inventori',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Tambah Produk'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Summary Cards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.3,
          children: [
            _buildInventorySummaryCard(
              'Total Produk',
              '$totalItems',
              Icons.inventory_2,
              Colors.blue,
            ),
            _buildInventorySummaryCard(
              'Stok Rendah',
              '$lowStock',
              Icons.warning_amber_rounded,
              Colors.orange,
            ),
            _buildInventorySummaryCard(
              'Stok Kritis',
              '$criticalStock',
              Icons.error_outline,
              Colors.red,
            ),
            _buildInventorySummaryCard(
              'Nilai Total Stok',
              'Rp ${totalValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
              Icons.attach_money,
              Colors.green,
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Filter Section
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari produk...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: 'Semua Kategori',
                underline: const SizedBox(),
                items: ['Semua Kategori', 'Makanan', 'Minuman', 'Snack', 'Dessert']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: 'Semua Status',
                underline: const SizedBox(),
                items: ['Semua Status', 'Aman', 'Stok Rendah', 'Stok Kritis']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Inventory Table
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    const Expanded(flex: 3, child: Text('Produk', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(flex: 2, child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(flex: 2, child: Text('Stok', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(flex: 2, child: Text('Min. Stok', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(flex: 2, child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 100, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              // Table Body
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: inventoryItems.length,
                itemBuilder: (context, index) {
                  return _buildInventoryRow(inventoryItems[index]);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInventorySummaryCard(String title, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildInventoryRow(InventoryItem item) {
  Color statusColor;
  Color statusBgColor;

  switch (item.status) {
    case 'Aman':
      statusColor = Colors.green.shade700;
      statusBgColor = Colors.green.shade50;
      break;
    case 'Stok Rendah':
      statusColor = Colors.orange.shade700;
      statusBgColor = Colors.orange.shade50;
      break;
    case 'Stok Kritis':
      statusColor = Colors.red.shade700;
      statusBgColor = Colors.red.shade50;
      break;
    default:
      statusColor = Colors.grey.shade700;
      statusBgColor = Colors.grey.shade50;
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(flex: 2, child: Text(item.category)),
        Expanded(
          flex: 2,
          child: Text('${item.stock} ${item.unit}', style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(flex: 2, child: Text('${item.minStock} ${item.unit}')),
        Expanded(
          flex: 2,
          child: Text(
            'Rp ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item.status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {},
                color: Colors.blue,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18),
                onPressed: () {},
                color: Colors.red,
                tooltip: 'Hapus',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildComingSoon() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📊', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'Halaman ini sedang dalam pengembangan',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Area Chart Painter
class AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    final linePath = Path();

    // Create curve data points
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.3),
      Offset(size.width, size.height * 0.2),
    ];

    // Fill path
    path.moveTo(0, size.height);
    linePath.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      
      path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p2.dx, p2.dy);
      linePath.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p2.dx, p2.dy);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Donut Chart Painter
class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final innerRadius = radius * 0.6;

    // Dark blue segment (70%)
    final paint1 = Paint()
      ..color = const Color(0xFF1a2332)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (radius - innerRadius) / 2),
      -90 * (3.14159 / 180),
      252 * (3.14159 / 180), // 70% of 360
      false,
      paint1,
    );

    // Blue segment (30%)
    final paint2 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (radius - innerRadius) / 2),
      162 * (3.14159 / 180),
      108 * (3.14159 / 180), // 30% of 360
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Model untuk Inventory Item
class InventoryItem {
  final String name;
  final String category;
  final int stock;
  final int minStock;
  final String unit;
  final int price;
  final String status;

  InventoryItem({
    required this.name,
    required this.category,
    required this.stock,
    required this.minStock,
    required this.unit,
    required this.price,
    required this.status,
  });
}