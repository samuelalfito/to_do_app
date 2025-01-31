import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

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
              body: _container(taskService.getTaskById(itemId)),
            ));
  }

  Widget _container(TaskServiceItem item) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
      ),
    );
  }
}
