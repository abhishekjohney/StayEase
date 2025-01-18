import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _noteController = TextEditingController();

  /// Adds a new note to the Firestore collection
  Future<void> _addNote() async {
    final noteContent = _noteController.text.trim();
    if (noteContent.isEmpty) {
      // Show a message if the note content is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'content': noteContent,
        'created_at': FieldValue.serverTimestamp(),
      });

      // Clear the input field after adding the note
      _noteController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully')),
      );
    } catch (e) {
      // Handle any errors that occur during the Firestore operation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add note: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        children: [
          // Input field to add new notes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addNote,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          const Divider(),
          // Display notes from Firestore in real-time
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final notes = snapshot.data?.docs ?? [];

                if (notes.isEmpty) {
                  return const Center(
                    child: Text('No notes available. Add some!'),
                  );
                }

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final content = note['content'] ?? 'No content';
                    final createdAt = note['created_at'] as Timestamp?;
                    final date = createdAt?.toDate();

                    return ListTile(
                      title: Text(content),
                      subtitle: date != null
                          ? Text(
                              'Created at: ${date.toLocal()}',
                              style: const TextStyle(fontSize: 12),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}
