import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/todo.dart';

enum RepositoryKeysEnum {
  todoList('todo_list');

  final String value;
  const RepositoryKeysEnum(this.value);
}

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(RepositoryKeysEnum.todoList.value) ?? '[]';
    final List jsonDecoded = jsonDecode(jsonString) as List;
    return jsonDecoded.map((value) => Todo.fromJson(value)).toList();
  }

  void saveTodoList(List<Todo> todoList) {
    final String jsonString = json.encode(todoList);
    sharedPreferences.setString(RepositoryKeysEnum.todoList.value, jsonString);
  }
}
