import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

import 'edit_task_view.dart';

class DetailTaskView extends StatelessWidget {
  DetailTaskView({super.key, required this.itemId});

  final String itemId;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormatter = DateFormat('HH:mm a');

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
        builder: (context, taskService, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Detail Task'),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  _container(taskService.getTaskById(itemId)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditTaskView(itemId: itemId),
                              ),
                            );
                          },
                          child: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () async {
                            bool? confirmDelete = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              taskService.deleteTask(itemId);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Delete'),
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ));
  }

  Widget _container(TaskServiceItem item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Text(
            item.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 10),
          Flexible(child: Text(item.description)),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(child: Text('Due Date: ')),
              Flexible(
                child: Text(dateFormatter.format(item.dueDate)),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  'Time: ',
                ),
              ),
              Flexible(child: Text(timeFormatter.format(item.dueDate))),
            ],
          ),
        ],
      ),
    );
  }
}
