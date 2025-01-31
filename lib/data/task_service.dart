import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class TaskService extends ChangeNotifier {
  late final List<TaskServiceItem> _tasks = [];

  List<TaskServiceItem> get tasks => _tasks;

  void addTask(TaskServiceItem task) {
    if (_tasks.isEmpty || task.dueDate.compareTo(_tasks.last.dueDate) == 0 || task.dueDate.compareTo(_tasks.last.dueDate) > 0) {
      _tasks.add(task);
    } else {
      for (int i = 0; i < _tasks.length; i++) {
        if (task.dueDate.compareTo(_tasks[i].dueDate) < 0) {
          _tasks.insert(i, task);
          break;
        }
      }
    }
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

  void updateTask(TaskServiceItem task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  TaskServiceItem getTaskById(String itemId) {
    return _tasks.firstWhere((task) => task.itemId == itemId);
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
