import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String orderType;
  final Function(List<Map<String, dynamic>>, String) onBack;

  const PaymentScreen({
    Key? key,
    required this.cartItems,
    required this.orderType,
    required this.onBack,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<Map<String, dynamic>> cartItems;
  late String orderType;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _cashAmountController = TextEditingController();
  
  String selectedPaymentMethod = 'Tunai';
  int membershipDiscount = 0;
  int discount = 24000;
  int service = 2300;
  int tax = 1700;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
    orderType = widget.orderType;
  }

  @override
  void dispose() {
    _notesController.dispose();
    _customerNameController.dispose();
    _cashAmountController.dispose();
    super.dispose();
  }

  int get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int));
  }

  int get total {
    return subtotal - discount + service + tax;
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      cartItems[index]['quantity'] += delta;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Left Panel - Order Details
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.wifi,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detail Pesanan',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    '#0001',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    orderType,
                                    style: const TextStyle(
                                      color: Color(0xFF1E5BAA),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Back to menu with saved cart
                            widget.onBack(cartItems, orderType);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.receipt),
                          label: const Text('Ubah Pesanan'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E5BAA),
                            side: const BorderSide(color: Color(0xFF1E5BAA)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Divider(),
                  
                  // Order Items Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            'Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Subtotal',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Order Items List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Item image and details
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.fastfood,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '@Rp${item['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Quantity controls
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => _updateQuantity(index, -1),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 32,
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item['quantity'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _updateQuantity(index, 1),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Subtotal
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Rp${((item['price'] as int) * (item['quantity'] as int)).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Notes section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Catatan Pesanan',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _notesController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tambahkan catatan pesanan bila perlu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Right Panel - Transaction Details
          Container(
            width: 450,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Detail Transaksi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Customer Name
                        TextField(
                          controller: _customerNameController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan nama pesanan',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Quick Actions
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.card_membership),
                                label: const Text('Membership'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: const BorderSide(color: Color(0xFF1E5BAA)),
                                  foregroundColor: const Color(0xFF1E5BAA),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.table_restaurant),
                                label: const Text('Nomor Meja'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: const BorderSide(color: Color(0xFF1E5BAA)),
                                  foregroundColor: const Color(0xFF1E5BAA),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.discount),
                                label: const Text('Diskon'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: const BorderSide(color: Color(0xFF1E5BAA)),
                                  foregroundColor: const Color(0xFF1E5BAA),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.receipt_long),
                                label: const Text('Pajak'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  side: const BorderSide(color: Color(0xFF1E5BAA)),
                                  foregroundColor: const Color(0xFF1E5BAA),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.room_service),
                          label: const Text('Layanan'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Color(0xFF1E5BAA)),
                            foregroundColor: const Color(0xFF1E5BAA),
                            minimumSize: const Size(double.infinity, 0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Price Summary
                        _buildPriceRow('Subtotal', subtotal),
                        _buildPriceRow('Diskon', discount, isNegative: true),
                        _buildPriceRow('Layanan', service),
                        _buildPriceRow('Pajak', tax),
                        const Divider(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TOTAL',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5BAA),
                              ),
                            ),
                            Text(
                              'Rp${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E5BAA),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Payment Method
                        const Text(
                          'Pembayaran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildPaymentButton('Tunai', Icons.money),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildPaymentButton('QRIS', Icons.qr_code),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Cash Input
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _cashAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan Uang yang Diterima',
                                  prefixIcon: const Icon(Icons.payments),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E5BAA),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                              child: const Text('Uang Pas'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        // Quick Amount Buttons
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildAmountButton('500'),
                            _buildAmountButton('1.000'),
                            _buildAmountButton('5.000'),
                            _buildAmountButton('50.000'),
                            _buildAmountButton('100.000'),
                          ],
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
  
  Widget _buildPriceRow(String label, int amount, {bool isNegative = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
          Text(
            '${isNegative ? '-' : ''}Rp${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isNegative ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPaymentButton(String label, IconData icon) {
    bool isSelected = selectedPaymentMethod == label;
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          selectedPaymentMethod = label;
        });
      },
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: isSelected ? Colors.blue[50] : Colors.white,
        side: BorderSide(
          color: isSelected ? const Color(0xFF1E5BAA) : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        foregroundColor: isSelected ? const Color(0xFF1E5BAA) : Colors.black54,
      ),
    );
  }
  
  Widget _buildAmountButton(String amount) {
    return OutlinedButton(
      onPressed: () {
        _cashAmountController.text = amount.replaceAll('.', '');
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: const BorderSide(color: Color(0xFF1E5BAA)),
        foregroundColor: const Color(0xFF1E5BAA),
      ),
      child: Text(amount),
    );
  }
}