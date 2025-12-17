import 'package:flutter/material.dart';

class Note {
  final String id;
  final DateTime dateTime;
  final String? content;
  final String? category;

  Note({
    required this.id,
    required this.dateTime,
    this.content,
    this.category,
  });
}

class SidebarNotes extends StatelessWidget {
  final Note? note;
  final VoidCallback? onAddNote;

  const SidebarNotes({
    Key? key,
    this.note,
    this.onAddNote,
  }) : super(key: key);

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}\n${_getMonthName(dt.month)}\n${dt.year}';
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    if (note == null) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 28, color: Colors.grey),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onAddNote,
              child: const Text(
                'Tambah Catatan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Jam
          Text(
            _formatTime(note!.dateTime),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5BAA),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Tanggal (Hari, Bulan, Tahun)
          Text(
            _formatDate(note!.dateTime),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E5BAA),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          // Optional: konten catatan jika ada
          if (note!.content != null && note!.content!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                note!.content!,
                style: const TextStyle(fontSize: 9, color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
