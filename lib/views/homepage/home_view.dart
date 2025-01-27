import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskModel, child) => Scaffold(
        backgroundColor: Color(0xff0a0c60),
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
            } else if (constraints.maxWidth < 700) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 10);
                },
              );
            } else if (constraints.maxWidth < 1000) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 10);
                },
              );
            } else if (constraints.maxWidth < 1600) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 50);
                },
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6),
                padding: const EdgeInsets.all(20),
                itemCount: taskModel.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return _container(taskModel.tasks[index], index, 50);
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
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff040544),
        boxShadow: const [
          BoxShadow(
              color: Color(0xff000000),
              offset: Offset(2.0, 2.0),
              blurRadius: 8,
              spreadRadius: 1),
          BoxShadow(
              color: Color(0xff3233a2),
              offset: Offset(-2.0, -2.0),
              blurRadius: 8,
              spreadRadius: 1),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
                value: item.isCompleted,
                onChanged: (value) {
                  final taskModel = context.read<TaskService>();
                  taskModel.updateTaskCompletion(item);
                }),
            Flexible(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            item.dueDate.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        item.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: maxLines,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
