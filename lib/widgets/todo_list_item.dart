import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.title,
    required this.date,
    required this.hour,
  }) : super(key: key);

  final String title;
  final String date;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[200],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$date - $hour',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
