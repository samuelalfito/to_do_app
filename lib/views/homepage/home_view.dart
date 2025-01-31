import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
  final DateFormat timeFormatter = DateFormat('HH:mm a');

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 1);
                },
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 2);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _container(item, index, maxLines) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.primaryContainer,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15,
              spreadRadius: 1),
          BoxShadow(
              color: Theme.of(context).colorScheme.secondaryContainer,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15,
              spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Checkbox(
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: item.isCompleted,
                        onChanged: (value) {
                          final taskModel = context.read<TaskService>();
                          taskModel.updateTaskCompletion(item);
                        }),
                  ),
                  Flexible(
                    flex: 5,
                    child: Text(
                      item.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: maxLines,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    () {
                      if (dateFormatter.format(item.dueDate) ==
                          dateFormatter.format(DateTime.now())) {
                        return 'Due Today';
                      } else if (item.dueDate.isBefore(DateTime.now())) {
                        return 'Overdue';
                      } else {
                        return dateFormatter.format(item.dueDate);
                      }
                    }(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: () {
                        if (item.dueDate.isBefore(
                            DateTime.now().subtract(Duration(days: 1)))) {
                          return Colors.red;
                        } else if (item.dueDate
                            .isBefore(DateTime.now().add(Duration(days: 1)))) {
                          return Colors.green[400];
                        }
                      }(),
                    ),
                  ),
                ),
                Flexible(child: Text(timeFormatter.format(item.dueDate))),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Text(item.description,
                  overflow: TextOverflow.ellipsis, maxLines: maxLines),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
