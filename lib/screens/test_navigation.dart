// File ini hanya untuk testing - bisa dihapus
// Untuk test sidebar catatan berfungsi, lakukan langkah berikut:
//
// 1. Jalankan: flutter run -d windows
// 2. Login dengan akun apapun
// 3. Navigasi ke halaman "Riwayat Pesanan" (dari home atau sidebar)
// 4. Lihat sidebar BIRU di sebelah kiri
// 5. Di bawah, ada icon catatan (📝) kuning dengan teks "Catatan"
// 6. KLIK icon atau teks "Catatan" 
// 7. Seharusnya membuka halaman "Catatan" dengan daftar catatan
// 8. Ada tombol + untuk tambah catatan baru
// 9. Ada tombol X untuk hapus catatan
//
// File-file yang digunakan:
// - lib/screens/order_history_screen.dart (sidebar dengan catatan)
// - lib/screens/notes_screen.dart (halaman catatan lengkap)
// - lib/screens/widgets/sidebar_notes.dart (model Note)
// - lib/utils/note_helper.dart (helper untuk membuat catatan)
//
// Routing di lib/main.dart:
// '/orders' -> OrderHistoryScreen
// '/notes' -> NotesScreen
