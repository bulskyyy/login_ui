import 'package:flutter/material.dart';
import 'order_history_screen.dart';
import 'payment_screen.dart';
import 'setting_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedMenuIndex = 0;
  String selectedCategory = 'Semua';
  String orderType = 'Dine In';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> cartItems = [];
  
  final List<String> categories = ['Semua', 'Paket', 'Ala Carte', 'Minuman'];
  
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Ayam Goreng Dada', 'price': 25000, 'stock': 32, 'category': 'Ala Carte'},
    {'name': 'Ayam Goreng Paha', 'price': 20000, 'stock': 5, 'category': 'Ala Carte'},
    {'name': 'Nasi Putih', 'price': 5000, 'stock': 15, 'category': 'Ala Carte'},
    {'name': 'Paket Family (2 Ayam Besar+3 Ayam)', 'price': 45000, 'stock': 32, 'category': 'Paket'},
    {'name': 'Choco Milkshake', 'price': 10000, 'stock': 22, 'category': 'Minuman'},
    {'name': 'Paket Kulit Nasi', 'price': 15000, 'stock': 12, 'category': 'Paket'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      int existingIndex = cartItems.indexWhere((cartItem) => cartItem['name'] == item['name']);
      
      if (existingIndex != -1) {
        cartItems[existingIndex]['quantity']++;
      } else {
        cartItems.add({
          'name': item['name'],
          'price': item['price'],
          'quantity': 1,
        });
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} ditambahkan ke pesanan'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }
  
  void _updateQuantity(int index, int delta) {
    setState(() {
      cartItems[index]['quantity'] += delta;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }
  
  int get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));
  }
  
  void _clearCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Semua Pesanan?'),
          content: const Text('Apakah Anda yakin ingin menghapus semua pesanan?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => cartItems.clear());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Semua pesanan telah dihapus'), backgroundColor: Colors.grey),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
  
  List<Map<String, dynamic>> get filteredMenuItems {
    var items = menuItems;
    
    if (selectedCategory != 'Semua') {
      items = items.where((item) => item['category'] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      items = items.where((item) => item['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return items;
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    body: Row(
      children: [
        _buildSidebar(),
        Expanded(
          child: _buildMainContent(), // Ubah bagian ini
        ),
      ],
    ),
  );
}

Widget _buildMainContent() {
  // Jika menu Bills (index 1), tampilkan OrderHistoryScreen
  if (selectedMenuIndex == 1) {
    return const OrderHistoryScreen();
  }
  
  // Jika menu Settings (index 2), tampilkan SettingScreen
  if (selectedMenuIndex == 2) {
    return const SettingScreen();
  }
  
  // Jika menu Reports (index 3), tampilkan ReportsScreen
  if (selectedMenuIndex == 3) {
    return const ReportsScreen();
  }
  
  // Menu lain tetap seperti biasa
  return Row(
    children: [
      Expanded(
        child: selectedMenuIndex == 0 ? _buildMenuPage() : _buildPlaceholderPage(),
      ),
      _buildOrderPanel(),
    ],
  );
}
  
  Widget _buildSidebar() {
  return Container(
    width: 80,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.lightBlue.shade700, Colors.lightBlue.shade600],
      ),
    ),
    child: Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: Colors.green.shade800, borderRadius: BorderRadius.circular(12)),
          child: const Column(
            children: [
              Icon(Icons.wifi, color: Colors.white, size: 24),
              SizedBox(height: 3),
              Text('Online', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildSidebarIcon(Icons.grid_view, 0, 'Menu'),
        _buildSidebarIcon(Icons.receipt_long, 1, 'Bills'),
        _buildSidebarIcon(Icons.settings, 2, 'Settings'),
        _buildSidebarIcon(Icons.bar_chart, 3, 'Reports'),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Text('13:24:59', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('23\nAug\n2025', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
  
Widget _buildSidebarIcon(IconData icon, int index, String tooltip) {
  bool isActive = selectedMenuIndex == index;
  return Tooltip(
    message: tooltip,
    child: InkWell(
      onTap: () => setState(() => selectedMenuIndex = index), // Kembalikan seperti semula
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E5BAA) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    ),
  );
}
  
  Widget _buildMenuPage() {
    return Column(
      children: [
        _buildHeader(),
        _buildCategoryTabs(),
        Expanded(child: _buildMenuGrid()),
      ],
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          const Text('Daftar Menu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[400]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Menu',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onChanged: (value) => setState(() => searchQuery = value),
                    ),
                  ),
                  if (searchQuery.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => setState(() {
                        _searchController.clear();
                        searchQuery = '';
                      }),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.white,
      child: Row(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () => setState(() => selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? const Color(0xFF1E5BAA) : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? const Color(0xFF1E5BAA) : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildMenuGrid() {
    if (filteredMenuItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text('Menu tidak ditemukan', style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: filteredMenuItems.length,
      itemBuilder: (context, index) => _buildMenuCard(filteredMenuItems[index]),
    );
  }
  
  Widget _buildMenuCard(Map<String, dynamic> item) {
    bool isLowStock = item['stock'] < 10;
    
    return InkWell(
      onTap: () => _addToCart(item),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, size: 60, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isLowStock ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Stok: ${item['stock']}',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text(
                    'Rp${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E5BAA)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderPanel() {
    return Container(
      width: 400,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: cartItems.isEmpty ? _buildEmptyCart() : _buildFilledCart(),
    );
  }
  
  Widget _buildEmptyCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderHeader(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 20),
                Text('Belum ada pesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text('Klik menu untuk menambahkan pesanan', style: TextStyle(fontSize: 14, color: Colors.grey[400])),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    cartItems: [],
                    orderType: orderType,
                    onBack: (updatedCart, updatedOrderType) => setState(() {
                      cartItems = updatedCart;
                      orderType = updatedOrderType;
                    }),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5BAA),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt, color: Colors.white),
                SizedBox(width: 10),
                Text('Open Bill', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFilledCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderHeader(),
        Row(
          children: [
            Expanded(child: _buildOrderTypeButton('Dine In')),
            const SizedBox(width: 10),
            Expanded(child: _buildOrderTypeButton('Take Away')),
          ],
        ),
        const SizedBox(height: 20),
        _buildCartHeader(),
        const Divider(),
        Expanded(child: _buildCartList()),
        _buildTotalSection(),
        const SizedBox(height: 20),
        _buildActionButtons(),
      ],
    );
  }
  
  Widget _buildOrderHeader() {
    return Row(
      children: [
        const Icon(Icons.receipt_long, size: 24),
        const SizedBox(width: 10),
        const Text('Pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
          child: const Text('#0001', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      ],
    );
  }
  
  Widget _buildOrderTypeButton(String label) {
    bool isSelected = orderType == label;
    return InkWell(
      onTap: () => setState(() => orderType = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E5BAA) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFF1E5BAA) : Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
  
  Widget _buildCartHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text('Menu', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54))),
          Expanded(flex: 2, child: Text('Quantity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54))),
          Expanded(flex: 2, child: Text('Subtotal', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black54))),
        ],
      ),
    );
  }
  
  Widget _buildCartList() {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text('@Rp${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => _updateQuantity(index, -1),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.remove, size: 16, color: Colors.red),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 28,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(6)),
                      child: Center(child: Text(item['quantity'].toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                    ),
                    InkWell(
                      onTap: () => _updateQuantity(index, 1),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.add, size: 16, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Rp${((item['price'] as int) * (item['quantity'] as int)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E5BAA))),
          Text(
            'Rp${totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E5BAA)),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: cartItems.isEmpty ? null : _clearCart,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: cartItems.isEmpty ? Colors.grey[300]! : Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.delete_outline, color: cartItems.isEmpty ? Colors.grey[300] : Colors.red),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: cartItems.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E5BAA),
                  side: const BorderSide(color: Color(0xFF1E5BAA), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  disabledBackgroundColor: Colors.grey[200],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt, size: 20),
                    SizedBox(width: 8),
                    Text('Open Bill', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: cartItems.isEmpty ? null : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    cartItems: List.from(cartItems),
                    orderType: orderType,
                    onBack: (updatedCart, updatedOrderType) => setState(() {
                      cartItems = updatedCart;
                      orderType = updatedOrderType;
                    }),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5BAA),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('Lanjutkan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlaceholderPage() {
    String pageName = ['Menu',  'Bills', 'Settings', 'Reports'][selectedMenuIndex];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text('$pageName Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[600])),
          const SizedBox(height: 10),
          Text('Under Construction', style: TextStyle(fontSize: 16, color: Colors.grey[400])),
        ],
      ),
    );
  }
}