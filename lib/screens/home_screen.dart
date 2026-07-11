import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';
import '../theme/app_theme.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Taskmaster',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<TaskSortOption>(
            icon: const Icon(Icons.sort, size: 28, color: Colors.white),
            onSelected: (option) => taskProvider.setSortOption(option),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskSortOption.dateNewest,
                child: Text('Най-нови'),
              ),
              const PopupMenuItem(
                value: TaskSortOption.dateOldest,
                child: Text('Най-стари'),
              ),
              const PopupMenuItem(
                value: TaskSortOption.alphabetical,
                child: Text('А-Я'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(context, taskProvider),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                final dateStr = DateFormat(
                  'dd.MM.yyyy HH:mm',
                  'bg',
                ).format(task.createdAt);

                return Dismissible(
                  key: Key(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    taskProvider.deleteTask(task.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Задачата е изтрита')),
                    );
                  },
                  child: Card(
                    color: task.isDone
                        ? colorScheme.success.withOpacity(0.1)
                        : theme.cardTheme.color,
                    elevation: task.isDone ? 0 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: task.isDone
                          ? BorderSide(color: colorScheme.success, width: 1)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      leading: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: task.isDone,
                          activeColor: colorScheme.success,
                          onChanged: (_) =>
                              taskProvider.toggleTaskStatus(task.id),
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isDone
                              ? colorScheme.success
                              : colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: task.isDone
                                  ? colorScheme.success
                                  : colorScheme.onSurface.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Добавена: $dateStr',
                            style: TextStyle(
                              fontSize: 14,
                              color: task.isDone
                                  ? colorScheme.success
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colorScheme.primary,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(task: task),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        foregroundColor: theme.floatingActionButtonTheme.foregroundColor,
        child: const Icon(Icons.add, size: 30),
        onPressed: () => _showAddTaskDialog(context),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, TaskProvider provider) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterText(context, provider, 'Всички', TaskFilter.all),
          _filterText(context, provider, 'Активни', TaskFilter.active),
          _filterText(context, provider, 'Завършени', TaskFilter.completed),
        ],
      ),
    );
  }

  Widget _filterText(
    BuildContext context,
    TaskProvider provider,
    String label,
    TaskFilter filter,
  ) {
    final isSelected = provider.currentFilter == filter;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => provider.setFilter(filter),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? Colors.orange.shade600
              : theme.colorScheme.primary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Нова задача',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Заглавие',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Заглавието е задължително'
                    : null,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Описание',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary),
                    foregroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text('Отказ'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(
                        titleController.text.trim(),
                        descController.text.trim(),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Задачата е добавена!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Запази'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
