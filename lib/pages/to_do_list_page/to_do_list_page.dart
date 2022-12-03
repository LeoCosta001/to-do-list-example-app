import 'package:flutter/material.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/repositories/todo_repository.dart';
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
  Todo? deletedTodo;
  int? deletedTodoIndex;

  // Repositories
  final TodoRepository todoRepository = TodoRepository();

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todoList = value;
      });
    });
  }

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
                        todoRepository.saveTodoList(todoList);
                        todoRepository.getTodoList();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
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
                                showDeleteTodoListConfirmationDialog();
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
    deletedTodo = todo;
    deletedTodoIndex = todoList.indexOf(todo);

    setState(() {
      todoList.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${todo.title} foi removida com sucesso'),
        backgroundColor: Colors.indigo,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              todoList.insert(deletedTodoIndex!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );

    todoRepository.saveTodoList(todoList);
  }

  void onDeleteAll() {
    setState(() {
      todoList.clear();
    });

    todoRepository.saveTodoList(todoList);
  }

  void showDeleteTodoListConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content: const Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDeleteAll();
            },
            style: TextButton.styleFrom(primary: Colors.indigo),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
