import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ClipRRect(
        // Create a mask to avoid overflow when sliding
        borderRadius: BorderRadius.circular(4),
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const DrawerMotion(), // Animation type
            children: [
              SlidableAction(
                label: 'Deletar',
                borderRadius: BorderRadius.circular(4),
                backgroundColor: Theme.of(context).errorColor, // Get theme color
                icon: Icons.delete,
                onPressed: (context) {},
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy - HH:mm').format(todo.date), // Formatting date
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
