import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, taskModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Create Task'),
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    final taskModel = context.read<TaskService>();
                    // Adding a task with dummy data
                    taskModel.addTask(
                      TaskServiceItem(
                        title: 'Dummy Task',
                        description: 'This is a dummy task',
                        dueDate: DateTime.now().toString()
                      ),
                    );
                  },
                  child: const Text('Create Dummy Task'),
                ),
              ),
            ));
  }
}
