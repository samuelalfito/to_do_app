class Task {
  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });
}

List<Task> getDummyTasks() {
  return [
    Task(
      title: 'Task 1',
      description: 'Description 1',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 2',
      description:
          'Description 2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 3',
      description: 'Description 3',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 4',
      description: 'Description 4',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 5',
      description: 'Description 5',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 6',
      description: 'Description 6',
      dueDate: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      title: 'Task 7',
      description: 'Description 7',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 8',
      description: 'Description 8',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 9',
      description: 'Description 9',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      title: 'Task 10',
      description: 'Description 10',
      dueDate: DateTime.now(),
      isCompleted: true,
    ),
  ];
}
