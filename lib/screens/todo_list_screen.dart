import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/models/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  final _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }
  // ignore: non_constant_identifier_names
  Widget AddTodoScreen() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTodoScreen()),
        );
      },
      child: const Text('Add Todo'),
    );
  }


  void _fetchTodos() async {
    List<Todo> fetchedTodos = await _databaseHelper.getTodos();
    setState(() {
      todos = fetchedTodos;
    });
  }

  void _toggleTodoStatus(Todo todo) async {
    todo.isCompleted = !todo.isCompleted;
    await _databaseHelper.update(todo);
    _fetchTodos();
  }

  void _deleteTodo(int id) async {
    await _databaseHelper.delete(id);
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          Todo todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => _toggleTodoStatus(todo),
            ),
            onLongPress: () => _deleteTodo(todo.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
