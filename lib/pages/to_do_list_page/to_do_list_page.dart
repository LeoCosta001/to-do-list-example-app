import 'package:flutter/material.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/widgets/todo_list_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  // Controllers
  TextEditingController todoController = TextEditingController();

  // States
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar Flutter',
                        ),
                        controller: todoController,
                      ),
                    ),
                    const SizedBox(width: 18),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.add(Todo(title: todoController.text, date: DateTime.now()));
                        });
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    children: [
                      for (Todo currentTodo in todoList)
                        TodoListItem(
                          todo: currentTodo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Você possui ${todoList.length} tarefas pendentes'),
                      ),
                      ElevatedButton(
                        onPressed: todoList.isNotEmpty
                            ? () {
                                setState(() {
                                  onDeleteAll();
                                });
                              }
                            : null, // Disable button when is empty
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.all(12),
                        ),
                        child: const Text(
                          'Limpar tudo',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Functions
  void onDelete(Todo todo) {
    setState(() {
      todoList.remove(todo);
    });
  }

  void onDeleteAll() {
    setState(() {
      todoList.clear();
    });
  }
}
