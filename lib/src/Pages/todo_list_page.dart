import 'package:flutter/material.dart';
import 'package:flutter_todos/src/Pages/add_todo_page.dart';
import 'package:flutter_todos/src/Models/todo.dart';
import 'package:flutter_todos/src/Pages/update_todo_page.dart';
import 'package:flutter_todos/src/Repositories/todo_repository.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      final List<Todo> data = await TodoRepo().fetchTodos();

      setState(() {
        todos = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching todos: $e');
    }
  }

  void navigateToAddTodo() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTodoPage(),
        ));
  }

  void navigateToUpdateTodo(Todo todo) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateTodoPage(todo: todo),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Todo List'),
      ),
      body: _isLoading == true
          ? Container(
              color: Colors.white,
              child: Center(
                child: Image.asset("assets/loader.gif"),
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: ValueKey<dynamic>(todos[index]),
                    background: Card(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                      child: const Center(
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.all(2)),
                            Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            Padding(padding: EdgeInsets.all(2)),
                            Text(
                              "Remove",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        todos.removeAt(index);
                        TodoRepo().deleteTodo(todo.id);
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        navigateToUpdateTodo(todo);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.all(5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 15)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(todo.title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                ),
                                const Padding(padding: EdgeInsets.all(2)),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: BoxDecoration(
                                          color: todo.completed
                                              ? Colors.green
                                              : Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        todo.completed
                                            ? 'Complete'
                                            : 'Not Complete',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
