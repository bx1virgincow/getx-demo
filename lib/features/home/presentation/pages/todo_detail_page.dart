import 'package:demo/features/home/domain/entities/todo_entity.dart';
import 'package:flutter/material.dart';

class TodoDetailPage extends StatefulWidget {
  final TodoEntity todoModel;
  const TodoDetailPage({
    super.key,
    required this.todoModel,
  });

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todoModel.title ?? 'Title',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.todoModel.body ?? 'Body',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
