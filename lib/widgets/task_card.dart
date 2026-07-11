import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/detail_screen.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        provider.deleteTask(task.id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Задачата е изтрита')));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: task.isDone ? const Color(0xFFF0F2F5) : Colors.white,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: task.isDone
                  ? const Color(0xFF6A769E)
                  : const Color(0xFF0082FD),
            ),
            onPressed: () => provider.toggleTaskStatus(task.id),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: task.isDone ? const Color(0xFF6A769E) : Colors.black87,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(task: task)),
          ),
        ),
      ),
    );
  }
}
