import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final Task task;
  const DetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final dateStr = DateFormat(
      'dd MMMM yyyy, HH:mm',
      'bg',
    ).format(task.createdAt);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Детайли за задачата'),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ЗАГЛАВИЕ
            Text(
              task.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 32,
                color: task.isDone
                    ? colorScheme.success
                    : colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
                const SizedBox(width: 8),
                Text(
                  'Добавена на: $dateStr',
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: task.isDone
                    ? colorScheme.success.withOpacity(0.1)
                    : colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: task.isDone
                      ? colorScheme.success
                      : colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    task.isDone ? Icons.check_circle : Icons.info_outline,
                    color: task.isDone
                        ? colorScheme.success
                        : colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    task.isDone ? 'СТАТУС: ЗАВЪРШЕНА' : 'СТАТУС: АКТИВНА',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: task.isDone
                          ? colorScheme.success
                          : colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Divider(
                height: 1,
                thickness: 1,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
            ),

            Text(
              'ОПИСАНИЕ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface.withOpacity(0.7),
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              task.description.isEmpty
                  ? 'Няма предоставено описание.'
                  : task.description,
              style: TextStyle(
                fontSize: 18,
                height: 1.6,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
