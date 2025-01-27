import 'package:flutter/material.dart';
import 'package:to_do_app/data/task_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Task> lists = getDummyTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0a0c60),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return _container(index);
              },
            );
          } else if (constraints.maxWidth < 1200) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              padding: const EdgeInsets.all(20),
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return _container(index);
              },
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              padding: const EdgeInsets.all(20),
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return _container(index);
              },
            );
          }
        },
      ),
    );
  }

  Widget _container(element) {
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
                value: lists[element].isCompleted,
                onChanged: (value) {
                  setState(() => lists[element].isCompleted = value!);
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
                            lists[element].title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            lists[element].dueDate.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        lists[element].description,
                        overflow: TextOverflow.ellipsis,
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
