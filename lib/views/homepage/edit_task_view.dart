import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/task_service.dart';

class EditTaskView extends StatefulWidget {
  final String itemId;

  const EditTaskView({super.key, required this.itemId});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    final task = Provider.of<TaskService>(context, listen: false).getTaskById(widget.itemId);
    if (task != null) {
      _titleController = TextEditingController(text: task.title);
      _descriptionController = TextEditingController(text: task.description);
      _selectedDate = task.dueDate;
      _selectedTime = TimeOfDay(hour: task.dueDate.hour, minute: task.dueDate.minute);
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
        builder: (context, taskService, child) {
          final task = taskService.getTaskById(widget.itemId);
          if (task == null) {
            return Center(child: Text('Task not found'));
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Task'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _container(task),
                    const SizedBox(width: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool? confirmSave = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Save'),
                                content: const Text(
                                    'Are you sure you want to save this task?'),
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
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmSave == true &&
                              _formKey.currentState!.validate()) {
                            final taskService = context.read<TaskService>();
                            DateTime dueDate = DateTime(
                              _selectedDate.year,
                              _selectedDate.month,
                              _selectedDate.day,
                              _selectedTime.hour,
                              _selectedTime.minute,
                            );

                            taskService.updateTask(
                              TaskServiceItem(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                dueDate: dueDate,
                              ),
                              widget.itemId,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    )
                  ],
                ),
              ));
        }
    );
  }

  Widget _container(TaskServiceItem item) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Title: '),
            TextFormField(
              maxLines: null,
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
              validator: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return 'Title is required';
                } else if (value.length > 50) {
                  return 'Title must be less than 50 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Text('Description (optional): '),
            TextFormField(
              maxLines: null,
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(child: Text('Due Date: ')),
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(DateTime
                            .now()
                            .year + 5),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                        '${_selectedDate.day}/${_selectedDate
                            .month}/${_selectedDate.year}'),
                  ),
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
                Flexible(
                  child: TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                          context: context, initialTime: _selectedTime);
                      if (pickedTime != null && pickedTime != _selectedTime) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text(_selectedTime.format(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
