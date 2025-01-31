import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class TaskService extends ChangeNotifier {
  late final List<TaskServiceItem> _tasks = [];

  List<TaskServiceItem> get tasks => _tasks;

  void addTask(TaskServiceItem task) {
    _tasks.add(task);
    _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    notifyListeners();
  }

  void removeTask(TaskServiceItem task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTaskCompletion(TaskServiceItem task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].setIsCompleted(!task.isCompleted);
      notifyListeners();
    }
  }

  void updateTask(TaskServiceItem newTask, String itemId) {
    final index = _tasks.indexWhere((task) => task.itemId == itemId);
    if (index != -1) {
      _tasks[index]
        ..title = newTask.title
        ..description = newTask.description
        ..dueDate = newTask.dueDate
        ..isCompleted = newTask.isCompleted;

      _tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      notifyListeners();
    }
  }

  TaskServiceItem? getTaskById(String itemId) {
    try {
      return _tasks.firstWhere((task) => task.itemId == itemId);
    } catch (e) {
      return null;
    }
  }

  void deleteTask(String itemId) {
    _tasks.removeWhere((task) => task.itemId == itemId);
    notifyListeners();
  }
}

class TaskServiceItem extends ChangeNotifier {
  final String itemId;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;

  TaskServiceItem({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  }) : itemId = Uuid().v4();

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setDueDate(DateTime dueDate) {
    this.dueDate = dueDate;
    notifyListeners();
  }

  void setIsCompleted(bool isCompleted) {
    this.isCompleted = isCompleted;
    notifyListeners();
  }
}
