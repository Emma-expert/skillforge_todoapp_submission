import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  

  void _saveTodo() async {
    // Get the entered values from the text controllers
    String title = _titleController.text;
    String description = _descriptionController.text;

    // Perform any validation or additional logic here

    // Create a new Todo object with the entered values
    Todo newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
    );

    await _databaseHelper.insert(newTodo);

    // Navigate back to the TodoListScreen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveTodo,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
