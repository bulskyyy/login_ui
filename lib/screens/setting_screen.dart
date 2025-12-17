import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String activeMenu = 'kelola-member';
  TextEditingController searchController = TextEditingController();
  Map<String, String?> syncStatus = {};
  bool showSuccessNotification = false;

  List<Member> members = [
    Member(id: 1, nama: 'Risyad Cavan Ayyuban', telepon: '0812-3456-7890'),
    Member(id: 2, nama: 'Gilang Riyanto', telepon: '0812-3456-7890'),
    Member(id: 3, nama: 'Muhamad Hanif Rafiq Sulaeman Sodiin', telepon: '0812-3456-7890'),
  ];

  final profileData = {
    'namaToko': 'SiMaBa',
    'namaCabang': 'Purwokerto',
    'username': 'simaba',
    'role': 'Admin',
    'email': 'admin@simaba.com',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Row(
        children: [
          // SIDEBAR PUTIH
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: const Text(
                    'Pengaturan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                // Menu Items - Scrollable
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildMenuItem(Icons.person_outline, 'Profil Pengguna', 'Lihat informasi akun', 'profil-pengguna'),
                      _buildMenuItem(Icons.people_outline, 'Kelola Member', 'Kelola member pelanggan', 'kelola-member'),
                      _buildMenuItem(Icons.percent, 'Kelola Diskon', 'Kelola diskon pelanggan', 'kelola-diskon'),
                      _buildMenuItem(Icons.description_outlined, 'Kelola Pajak', 'Kelola pajak pelanggan', 'kelola-pajak'),
                      _buildMenuItem(Icons.headset_mic_outlined, 'Kelola Layanan', 'Kelola layanan pelanggan', 'kelola-layanan'),
                      _buildMenuItem(Icons.print_outlined, 'Kelola Printer', 'Tambah atau hapus printer', 'kelola-printer'),
                      _buildMenuItem(Icons.refresh, 'Sinkronisasi Data', 'Sinkronisasi data dengan server', 'sinkronisasi-data'),
                      _buildMenuItem(Icons.logout, 'Logout', 'Keluar dari akun', 'logout', isLogout: true),
                    ],
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
                  child: const Column(
                    children: [
                      Text('13:24:59', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      Text('23 Aug 2025', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // KONTEN UTAMA
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: _buildContent(),
                ),
                if (showSuccessNotification)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Sinkronisasi Produk Berhasil',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
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

  Widget _buildMenuItem(IconData icon, String title, String subtitle, String menuId, {bool isLogout = false}) {
    final isActive = activeMenu == menuId;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (menuId == 'logout') {
            _showLogoutDialog();
          } else {
            setState(() => activeMenu = menuId);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: isLogout ? Colors.red : Colors.grey.shade700, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isLogout ? Colors.red : Colors.black)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: isLogout ? Colors.red.shade300 : Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
  switch (activeMenu) {
    case 'profil-pengguna':
      return _buildProfilPengguna();
    case 'kelola-member':
      return _buildKelolaMember();
    case 'kelola-diskon':
      return _buildKelolaDiskon();
    case 'kelola-pajak':
      return _buildKelolaPajak();
    case 'kelola-layanan':
      return _buildKelolaLayanan();
    case 'kelola-printer':
      return _buildKelolaPrinter();
    case 'sinkronisasi-data':
      return _buildSinkronisasiData();
    default:
      return _buildComingSoon();
  }
}

  Widget _buildProfilPengguna() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Profil Pengguna', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Informasi Profil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      SizedBox(
                        width: (constraints.maxWidth - 24) / 2,
                        child: _buildProfileCard('Nama Toko', profileData['namaToko']!),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 24) / 2,
                        child: _buildProfileCard('Nama Cabang', profileData['namaCabang']!),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 24) / 2,
                        child: _buildProfileCard('Username', profileData['username']!),
                      ),
                      SizedBox(
                        width: (constraints.maxWidth - 24) / 2,
                        child: _buildProfileCard('ROLE', profileData['role']!),
                      ),
                      SizedBox(
                        width: constraints.maxWidth,
                        child: _buildProfileCard('Email', profileData['email']!),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildKelolaMember() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Kelola Member', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 320,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Cari Member',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 800 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.1,
              ),
              itemCount: members.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _buildAddMemberCard();
                return _buildMemberCard(members[index - 1]);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddMemberCard() {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 32, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tambah Member\nBaru',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildMemberCard(Member member) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 32, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 60,
                    child: Text('Nama', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(member.nama, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 60,
                    child: Text('Telepon', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(member.telepon, style: const TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () => _deleteMember(member.id),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.delete, size: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // KELOLA LAYANAN
Widget _buildKelolaLayanan() {
  final layananList = [
    LayananItem(
      id: 1,
      nama: 'Delivery',
      nilai: '10%',
      deskripsi: 'Layanan antar makanan',
      icon: Icons.shopping_bag_outlined,
    ),
    LayananItem(
      id: 2,
      nama: 'Packing',
      nilai: '5%',
      deskripsi: 'Biaya kemasan takeaway',
      icon: Icons.shopping_bag_outlined,
    ),
    LayananItem(
      id: 3,
      nama: 'Private Dining',
      nilai: '15%',
      deskripsi: 'Layanan ruang makan privat',
      icon: Icons.shopping_bag_outlined,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Kelola Layanan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 800 ? 2 : 1);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.1,
            ),
            itemCount: layananList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildAddCard('Tambah Layanan\nBaru');
              return _buildLayananCard(layananList[index - 1]);
            },
          );
        },
      ),
    ],
  );
}

Widget _buildLayananCard(LayananItem layanan) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                child: Icon(layanan.icon, size: 32, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nama', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(layanan.nama, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nilai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(layanan.nilai, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Deskripsi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(layanan.deskripsi, style: const TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.delete, size: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// KELOLA DISKON
Widget _buildKelolaDiskon() {
  final diskonList = [
    DiskonItem(
      id: 1,
      nama: 'Diskon Member VIP',
      nilai: '15%',
      deskripsi: 'Diskon khusus untuk member VIP',
      icon: Icons.percent,
    ),
    DiskonItem(
      id: 2,
      nama: 'Diskon Hari Raya',
      nilai: '25%',
      deskripsi: 'Diskon spesial untuk perayaan hari raya',
      icon: Icons.percent,
    ),
    DiskonItem(
      id: 3,
      nama: 'Diskon Weekend',
      nilai: '10%',
      deskripsi: 'Diskon khusus akhir pekan',
      icon: Icons.percent,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Kelola Diskon', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 800 ? 2 : 1);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.1,
            ),
            itemCount: diskonList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildAddCard('Tambah Diskon Baru');
              return _buildDiskonCard(diskonList[index - 1]);
            },
          );
        },
      ),
    ],
  );
}

Widget _buildDiskonCard(DiskonItem diskon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                child: Icon(diskon.icon, size: 32, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nama', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(diskon.nama, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nilai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(diskon.nilai, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Deskripsi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(diskon.deskripsi, style: const TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.delete, size: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// KELOLA PAJAK
Widget _buildKelolaPajak() {
  final pajakList = [
    PajakItem(
      id: 1,
      nama: 'PPN',
      nilai: '11%',
      deskripsi: 'Pajak Pertambahan Nilai',
      icon: Icons.description_outlined,
    ),
    PajakItem(
      id: 2,
      nama: 'Service Charge',
      nilai: '5%',
      deskripsi: 'Biaya layanan restoran',
      icon: Icons.description_outlined,
    ),
    PajakItem(
      id: 3,
      nama: 'Tax Restaurant',
      nilai: '10%',
      deskripsi: 'Pajak khusus restoran',
      icon: Icons.description_outlined,
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Kelola Pajak', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 800 ? 2 : 1);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.1,
            ),
            itemCount: pajakList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildAddCard('Tambah Pajak Baru');
              return _buildPajakCard(pajakList[index - 1]);
            },
          );
        },
      ),
    ],
  );
}

Widget _buildPajakCard(PajakItem pajak) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                child: Icon(pajak.icon, size: 32, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nama', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(pajak.nama, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Nilai', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(pajak.nilai, style: const TextStyle(fontSize: 12))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 60, child: Text('Deskripsi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  const Text(': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  Expanded(child: Text(pajak.deskripsi, style: const TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.delete, size: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// KELOLA PRINTER
Widget _buildKelolaPrinter() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kelola Printer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 32),
        
        // Deteksi Printer Otomatis
        const Text('Deteksi Printer Otomatis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check, color: Colors.green.shade700, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Sistem sedang mencari printer yang tersedia...',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: 'Cari nama printer...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Available Printers
        _buildPrinterItem(
          name: 'Canon PIXMA MP287',
          status: 'Bluetooth - Ready',
          isReady: true,
          showAddButton: true,
        ),
        
        const SizedBox(height: 16),
        
        _buildPrinterItem(
          name: 'Canon PIXMA MP287',
          status: 'Bluetooth - Offline',
          isReady: false,
          showAddButton: false,
        ),
        
        const SizedBox(height: 24),
        
        // Scan Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Scan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Printer Tersimpan
        const Text('Printer Tersimpan (2)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        _buildSavedPrinterItem(
          name: 'Canon PIXMA MP287',
          status: 'Bluetooth - Default Printer',
          statusLabel: 'AKTIF',
          statusColor: Colors.green.shade100,
          statusTextColor: Colors.green.shade700,
        ),
        
        const SizedBox(height: 16),
        
        _buildSavedPrinterItem(
          name: 'Canon PIXMA MP287',
          status: 'Bluetooth - Backup Printer',
          statusLabel: 'STANDBY',
          statusColor: Colors.orange.shade100,
          statusTextColor: Colors.orange.shade700,
        ),
        
        const SizedBox(height: 24),
        
        // Kelola Semua Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Kelola Semua', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Pengaturan Umum
        const Text('Pengaturan umum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        const Text('Printer Default', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        
        TextField(
          decoration: InputDecoration(
            hintText: 'Cari printer tersimpan...',
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        
        const SizedBox(height: 24),
        
        const Text('Ukuran Kertas Struk', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('58 mm'),
                value: '58mm',
                groupValue: '80mm',
                onChanged: (value) {},
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('80 mm'),
                value: '80mm',
                groupValue: '80mm',
                onChanged: (value) {},
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Bottom Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Reset ke Default', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Simpan Pengaturan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPrinterItem({
  required String name,
  required String status,
  required bool isReady,
  required bool showAddButton,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            ],
          ),
        ),
        if (isReady) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('READY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
          ),
          const SizedBox(width: 12),
        ],
        if (!isReady) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('OFFLINE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red.shade700)),
          ),
          const SizedBox(width: 12),
        ],
        if (showAddButton)
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Tambah'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        else
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Coba lagi', style: TextStyle(color: Colors.black87)),
          ),
      ],
    ),
  );
}

Widget _buildSavedPrinterItem({
  required String name,
  required String status,
  required String statusLabel,
  required Color statusColor,
  required Color statusTextColor,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(statusLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusTextColor)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Connect'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Hapus'),
        ),
      ],
    ),
  );
}

// Helper Widget untuk Add Card
Widget _buildAddCard(String text) {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
            child: const Icon(Icons.add, size: 32, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

  Widget _buildSinkronisasiData() {
    final syncItems = [
      SyncItem(id: 'produk', icon: Icons.inventory_2_outlined, title: 'Sinkronisasi Produk', subtitle: 'Sinkronisasi produk dari server ke database'),
      SyncItem(id: 'kategori', icon: Icons.grid_view, title: 'Sinkronisasi Kategori', subtitle: 'Sinkronisasi kategori dari server ke database'),
      SyncItem(id: 'member', icon: Icons.people_outline, title: 'Sinkronisasi Member', subtitle: 'Sinkronisasi member dari server ke database'),
      SyncItem(id: 'diskon', icon: Icons.percent, title: 'Sinkronisasi Diskon', subtitle: 'Sinkronisasi diskon dari server ke database'),
      SyncItem(id: 'order', icon: Icons.shopping_cart_outlined, title: 'Sinkronisasi Order', subtitle: 'Sinkronisasi order dari server ke database'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sinkronisasi Data', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        ...syncItems.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Icon(item.icon, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(item.subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _handleSync(item.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(syncStatus[item.id] == 'loading' ? 'Loading...' : 'Sinkronisasi'),
                ),
              ],
            ),
          ),
        )),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleSyncAll,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Sinkronisasi Semua', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoon() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('⚙️', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text('Halaman ini sedang dalam pengembangan', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  void _handleSync(String id) {
    setState(() => syncStatus[id] = 'loading');
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => syncStatus[id] = 'success');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => syncStatus[id] = null);
        });
      }
    });
  }

  void _handleSyncAll() {
    setState(() => showSuccessNotification = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => showSuccessNotification = false);
    });
  }

  void _deleteMember(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus member ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              setState(() => members.removeWhere((m) => m.id == id));
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

// MODEL CLASSES
class Member {
  final int id;
  final String nama;
  final String telepon;
  Member({required this.id, required this.nama, required this.telepon});
}

class SyncItem {
  final String id;
  final IconData icon;
  final String title;
  final String subtitle;
  SyncItem({required this.id, required this.icon, required this.title, required this.subtitle});
}

// Model untuk Layanan
class LayananItem {
  final int id;
  final String nama;
  final String nilai;
  final String deskripsi;
  final IconData icon;
  
  LayananItem({
    required this.id,
    required this.nama,
    required this.nilai,
    required this.deskripsi,
    required this.icon,
  });
}

// Model untuk Diskon
class DiskonItem {
  final int id;
  final String nama;
  final String nilai;
  final String deskripsi;
  final IconData icon;
  
  DiskonItem({
    required this.id,
    required this.nama,
    required this.nilai,
    required this.deskripsi,
    required this.icon,
  });
}

// Model untuk Pajak
class PajakItem {
  final int id;
  final String nama;
  final String nilai;
  final String deskripsi;
  final IconData icon;
  
  PajakItem({
    required this.id,
    required this.nama,
    required this.nilai,
    required this.deskripsi,
    required this.icon,
  });
}