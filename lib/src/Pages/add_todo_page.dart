import 'package:flutter/material.dart';
import 'package:flutter_todos/src/Repositories/todo_repository.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController titleController = TextEditingController();

  bool status = false;
  String statusText = "Not Completed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Center(
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Title',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Center(
                child: Row(
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
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                TodoRepo().createTodo(titleController.text, status, context);
              },
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
