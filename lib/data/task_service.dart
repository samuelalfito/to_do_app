import 'package:flutter/cupertino.dart';

class TaskService extends ChangeNotifier {
  late final List<TaskServiceItem> _tasks = [];

  List<TaskServiceItem> get tasks => _tasks;

  void addTask(TaskServiceItem task) {
    _tasks.add(task);
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
}

class TaskServiceItem extends ChangeNotifier {
  String title;
  String description;
  String dueDate;
  bool isCompleted;

  TaskServiceItem({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setDueDate(String dueDate) {
    this.dueDate = dueDate;
    notifyListeners();
  }

  void setIsCompleted(bool isCompleted) {
    this.isCompleted = isCompleted;
    notifyListeners();
  }
}
