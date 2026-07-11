import 'package:flutter/material.dart';
import '../models/task.dart';

enum TaskSortOption { dateNewest, dateOldest, alphabetical }

enum TaskFilter { all, active, completed }

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Резервация за почивка',
      description: 'Да разгледам хотелите и да запазя стая за уикенда.',
      isDone: false,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Task(
      id: '2',
      title: 'Пазаруване за вкъщи',
      description: 'Мляко, яйца, хляб, кафе и плодове.',
      isDone: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Task(
      id: '3',
      title: 'Тест по Java',
      description: '9 седмица от 8:00 във 2 аула',
      isDone: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  TaskSortOption _sortOption = TaskSortOption.dateNewest;
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks {
    List<Task> filteredTasks = _tasks;
    if (_filter == TaskFilter.active) {
      filteredTasks = _tasks.where((t) => !t.isDone).toList();
    } else if (_filter == TaskFilter.completed) {
      filteredTasks = _tasks.where((t) => t.isDone).toList();
    } else {
      filteredTasks = [..._tasks];
    }

    if (_sortOption == TaskSortOption.dateNewest) {
      filteredTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortOption == TaskSortOption.dateOldest) {
      filteredTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else if (_sortOption == TaskSortOption.alphabetical) {
      filteredTasks.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
    }
    return filteredTasks;
  }

  TaskSortOption get sortOption => _sortOption;
  TaskFilter get currentFilter => _filter;

  void setSortOption(TaskSortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(String title, String description) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }
}
