import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Add Tasks'),
    
    ),
    body: Padding(padding: EdgeInsets.all(8),child: Column(children: [

      TextField(decoration: InputDecoration(labelText: 'Title'),controller:_titleController),
      TextField(decoration: InputDecoration(labelText: 'description'),controller:_descriptionController),
        SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              final title = _titleController.text;
              final description = _descriptionController.text;
               if (title.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('tasks').add({
                    'title': title,
                    'description': description,
                    'timestamp': Timestamp.now(),
                  });
                 
                }

              


              



            }, child: Text('Add Text'))

    ],),),
    
    
    );
  }
}