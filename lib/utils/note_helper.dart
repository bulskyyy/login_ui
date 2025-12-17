import '../screens/widgets/sidebar_notes.dart';

class NoteHelper {
  /// Buat catatan baru dengan waktu saat ini
  static Note createNoteNow({
    required String id,
    String? content,
    String? category,
  }) {
    return Note(
      id: id,
      dateTime: DateTime.now(),
      content: content,
      category: category,
    );
  }

  /// Buat catatan dengan waktu custom
  static Note createNoteCustom({
    required String id,
    required DateTime dateTime,
    String? content,
    String? category,
  }) {
    return Note(
      id: id,
      dateTime: dateTime,
      content: content,
      category: category,
    );
  }

  /// List catatan dummy untuk testing
  static List<Note> getDummyNotes() {
    final now = DateTime.now();
    return [
      Note(
        id: '1',
        dateTime: now,
        content: 'Pesanan banyak hari ini',
        category: 'reminder',
      ),
      Note(
        id: '2',
        dateTime: now.subtract(const Duration(hours: 2)),
        content: 'Stok bahan hampir habis',
        category: 'urgent',
      ),
    ];
  }
}
