import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTaskScreen extends StatefulWidget {

  final String taskId;
  final String initialTaskTitle;
  final String initialTaskDescription;

   EditTaskScreen({
    required this.taskId,
    required this.initialTaskTitle,
    required this.initialTaskDescription


  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
    late TextEditingController  _titleController;
    late TextEditingController _descriptionController;

    @override
    void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.initialTaskTitle);
    _descriptionController = TextEditingController(text: widget.initialTaskDescription);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title: Text('Edit'),),body: Column(children: [
      TextField(decoration: InputDecoration(labelText: 'Title'),controller: _titleController,),
      TextField(decoration: InputDecoration(labelText: 'description'),controller: _descriptionController,),
         const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final description = _descriptionController.text;

                if (title.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(widget.taskId)
                      .update({
                    'title': title,
                    'description': description,
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update Task'),
            ),
    ],),);
  }
}