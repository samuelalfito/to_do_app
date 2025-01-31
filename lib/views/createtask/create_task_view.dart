import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/task_service.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, taskModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Create Task'),
              ),
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 600) {
                    return _phoneLayout();
                  } else {
                    return _desktopLayout();
                  }
                },
              ),
            ));
  }

  Widget _phoneLayout() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Title: '),
              TextFormField(
                maxLines: null,
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
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
                          lastDate: DateTime(DateTime.now().year + 5),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final taskModel = context.read<TaskService>();

                    taskModel.addTask(
                      TaskServiceItem(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate:
                            '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day} ${_selectedTime.format(context)}',
                      ),
                    );
                  }
                },
                child: const Text('Create Task'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Title: '),
              TextFormField(
                maxLines: null,
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
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
                          lastDate: DateTime(DateTime.now().year + 5),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final taskModel = context.read<TaskService>();

                    taskModel.addTask(
                      TaskServiceItem(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate:
                            '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day} ${_selectedTime.format(context)}',
                      ),
                    );
                  }
                },
                child: const Text('Create Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
