import 'package:flutter/material.dart';
import 'package:to_do_list/pages/to_do_list_page/to_do_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListPage(),
    );
  }
}
