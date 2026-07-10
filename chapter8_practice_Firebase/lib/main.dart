import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final startup = await FirebaseStartup.initialize();
  runApp(NotesApp(startup: startup));
}

class FirebaseStartup {
  final bool ready;
  final String? errorMessage;

  const FirebaseStartup._({required this.ready, this.errorMessage});

  const FirebaseStartup.ready() : this._(ready: true);

  const FirebaseStartup.failed(String message)
    : this._(ready: false, errorMessage: message);

  static Future<FirebaseStartup> initialize() async {
    try {
      await Firebase.initializeApp();
      return const FirebaseStartup.ready();
    } catch (error) {
      return FirebaseStartup.failed(error.toString());
    }
  }
}

class NotesApp extends StatelessWidget {
  final FirebaseStartup startup;

  const NotesApp({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: startup.ready
          ? const NotesHome()
          : FirebaseSetupRequired(errorMessage: startup.errorMessage),
    );
  }
}

class FirebaseSetupRequired extends StatelessWidget {
  final String? errorMessage;

  const FirebaseSetupRequired({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Notes'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.cloud_off_outlined,
            size: 72,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 20),
          const Text(
            'Firebase setup required',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'The CRUD app is ready, but this project still needs a real Firebase Android configuration before it can connect to Firestore.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 24),
          const _SetupStep(
            number: '1',
            text:
                'Create a Firebase project and register an Android app with package name:',
          ),
          const SelectableText(
            'com.example.chapter8_practice_firebase',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 14),
          const _SetupStep(
            number: '2',
            text: 'Download google-services.json from Firebase Console.',
          ),
          const _SetupStep(
            number: '3',
            text: 'Place it inside android/app/, then run the project again.',
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 24),
            const Text(
              'Current startup error:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SelectableText(
              errorMessage!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}

class _SetupStep extends StatelessWidget {
  final String number;
  final String text;

  const _SetupStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blueAccent,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  CollectionReference<Map<String, dynamic>> get notesCollection =>
      FirebaseFirestore.instance.collection('notes');

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> addNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      _showMessage('Please enter both title and content.');
      return;
    }

    try {
      await notesCollection.add({
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
      titleController.clear();
      contentController.clear();
      _showMessage('Note added.');
    } catch (error) {
      _showMessage('Error adding note: $error');
    }
  }

  Future<void> updateNote(
    String documentId,
    String title,
    String content,
  ) async {
    if (title.trim().isEmpty || content.trim().isEmpty) {
      _showMessage('Please enter both title and content.');
      return;
    }

    try {
      await notesCollection.doc(documentId).update({
        'title': title.trim(),
        'content': content.trim(),
      });
      _showMessage('Note updated.');
    } catch (error) {
      _showMessage('Error updating note: $error');
    }
  }

  Future<void> deleteNote(String documentId) async {
    try {
      await notesCollection.doc(documentId).delete();
      _showMessage('Note deleted.');
    } catch (error) {
      _showMessage('Error deleting note: $error');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _openEditDialog(QueryDocumentSnapshot<Map<String, dynamic>> note) {
    final data = note.data();
    final editTitle = TextEditingController(text: data['title'] ?? '');
    final editContent = TextEditingController(text: data['content'] ?? '');

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTitle,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: editContent,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateNote(note.id, editTitle.text, editContent.text);
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).whenComplete(() {
      editTitle.dispose();
      editContent.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Notes'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Note Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Note Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ),
          ElevatedButton.icon(
            onPressed: addNote,
            icon: const Icon(Icons.add),
            label: const Text('Add Note'),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'All Notes:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: notesCollection
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Error loading notes:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final notes = snapshot.data!.docs;
                if (notes.isEmpty) {
                  return const Center(child: Text('No notes found yet.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: notes.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final data = note.data();

                    return ListTile(
                      title: Text(data['title'] ?? ''),
                      subtitle: Text(data['content'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _openEditDialog(note),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteNote(note.id),
                          ),
                        ],
                      ),
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
}
