import 'package:flutter/material.dart';
import '../Config/graphql_service.dart';
import '../Models/todo.dart';

class TodoRepo {
  Future<void> createTodo(title, status, BuildContext context) async {
    try {
      const mutation = '''
        mutation(\$title: String!, \$completed: Boolean!) {
          createTodo(input: {
            title: \$title,
            completed: \$completed
          }) {
            id
            title
            completed
          }
        }
      ''';

      await GraphQLService().performMutation(mutation, variables: {
        'title': title,
        'completed': status,
      });

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error creating todo: $e');
    }
  }

  Future<void> updateTodo(id, title, status, BuildContext context) async {
    try {
      const mutation = '''
        mutation(\$id: ID!, \$title: String!, \$completed: Boolean!) {
          updateTodo(id: \$id, input: {
            title: \$title,
            completed: \$completed
          }) {
            id
            title
            completed
          }
        }
      ''';

      await GraphQLService().performMutation(mutation, variables: {
        'id': id,
        'title': title,
        'completed': status,
      });

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error updating todo: $e');
    }
  }

  Future fetchTodos() async {
    try {
      const query = '''
        query {
          todos {
            data {
              id
              title
              completed
            }
          }
        }
      ''';

      final result = await GraphQLService().performQuery(query);
      final List<dynamic> data = result.data?['todos']['data'];

      // return data;

      return data.map((json) => Todo.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching todos: $e');
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      const mutation = '''
      mutation(\$id: ID!) {
        deleteTodo(id: \$id)
      }
    ''';

      await GraphQLService().performMutation(mutation, variables: {
        'id': todoId,
      });
    } catch (e) {
      debugPrint('Error deleting todo: $e');
    }
  }
}
