import 'package:flutter/material.dart';
import 'package:flutter_todos/src/Models/todo.dart';
import '../Repositories/todo_repository.dart';

class UpdateTodoPage extends StatefulWidget {
  final Todo todo;

  const UpdateTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _UpdateTodoPageState createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool status = false;
  String statusText = "Not Completed";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    status = widget.todo.completed ? true : false;
    statusText = widget.todo.completed ? "Completed" : "Not Completed";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              children: [
                const Text('Status'),
                const Padding(padding: EdgeInsets.all(2)),
                Switch(
                  value: status,
                  onChanged: (val) {
                    if (status == false) {
                      setState(() {
                        status = true;
                        statusText = "Completed";
                      });
                    } else {
                      setState(() {
                        status = false;
                        statusText = "Not Completed";
                      });
                    }
                    status = val;
                  },
                ),
                const Padding(padding: EdgeInsets.all(2)),
                Text(statusText),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                TodoRepo().createTodo(titleController.text, status, context);
              },
              child: const Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
