import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  String title = '';
  String description = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, taskModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Create Task'),
              ),
              body: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  TextField(
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(DateTime.now().year + 5),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                          'Due Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}')),
                  ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (pickedTime != null && pickedTime != _selectedTime) {
                          setState(() {
                            _selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Text('Time: ${_selectedTime.format(context)}')),
                  ElevatedButton(
                    onPressed: () {
                      final taskModel = context.read<TaskService>();
                      taskModel.addTask(
                        TaskServiceItem(
                          title: title,
                          description: description,
                          dueDate:
                              '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day} ${_selectedTime.format(context)}',
                        ),
                      );
                    },
                    child: const Text('Create Task'),
                  ),
                ],
              ),
            ));
  }
}
