import 'package:flutter/material.dart';
import 'widgets/sidebar_notes.dart';
import '../utils/note_helper.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> notes;
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notes = NoteHelper.getDummyNotes();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _addNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Catatan'),
          content: TextField(
            controller: _contentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Masukkan catatan...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_contentController.text.isNotEmpty) {
                  setState(() {
                    notes.insert(
                      0,
                      NoteHelper.createNoteNow(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        content: _contentController.text,
                        category: 'custom',
                      ),
                    );
                  });
                  _contentController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        backgroundColor: const Color(0xFF1E5BAA),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.note, color: Color(0xFF1E5BAA)),
              title: Text(
                note.content ?? 'Catatan kosong',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${note.dateTime.day}/${note.dateTime.month}/${note.dateTime.year} '
                '${note.dateTime.hour.toString().padLeft(2, '0')}:${note.dateTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteNote(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E5BAA),
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
