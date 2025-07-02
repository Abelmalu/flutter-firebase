import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/edit_task_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tasks'), // Added const for better performance
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Added const
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'), // Added const
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'), // Corrected labelText, added const
              controller: _descriptionController,
            ),
            const SizedBox(height: 10), // Added const
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim(); // Trim whitespace
                final description = _descriptionController.text.trim(); // Trim whitespace

                if (title.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('tasks').add({
                    'title': title,
                    'description': description,
                    'timestamp': Timestamp.now(),
                  });
                  // Clear text fields after adding
                  _titleController.clear();
                  _descriptionController.clear();
                } else {
                  // Optional: Show a snackbar or message if title is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title cannot be empty!')),
                  );
                }
              },
              child: const Text('Add Task'), // Corrected button text, added const
            ),
            // --- FIX FOR THE ASSERTION ERROR: Wrapped StreamBuilder in Expanded ---
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('tasks').orderBy('timestamp', descending: true).snapshots(), // Ordered by timestamp
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Wrapped in Center, added const
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No Tasks Found')); // Added const
                  }

                  final tasks = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final taskData = task.data(); // No need for 'as Map<String, dynamic>' if using dynamic
                      final taskId = task.id; // Get document ID for potential delete/edit operations

                      return ListTile(
                        title: Text(taskData['title'] ?? 'No Title'), // Handle potential null
                        subtitle: Text(taskData['description'] ?? 'No Description'), // Handle potential null
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // TODO: Implement edit functionality (e.g., show a dialog to edit)
                                Navigator.push(context, MaterialPageRoute(builder:(context)=> EditTaskScreen(taskId: task.id,initialTaskTitle: task['title'],initialTaskDescription: task['description'])));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                             
                                _deleteTask(task.id);
                              },
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
      ),
    );
  }

   void _deleteTask( String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

}
