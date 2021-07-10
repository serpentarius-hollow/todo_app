import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'bloc/form/form_bloc.dart' as form;
import 'bloc/todo/todo_bloc.dart';
import 'todo.dart';

String formatDate(DateTime date) {
  return DateFormat('EEEE, d MMMM @ hh:mm a').format(date);
}

class TodoForm extends StatelessWidget {
  final Todo? todo;

  const TodoForm({this.todo});

  void save(TodoBloc todoBloc, String taskName, DateTime taskDate) {
    if (todo != null) {
      todoBloc.add(TodoUpdated(
        todo!.copyWith(
          taskName: taskName,
          taskDate: taskDate,
        ),
      ));
    } else {
      todoBloc.add(TodoAdded(
        Todo(
          taskName: taskName,
          taskDate: taskDate!,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<form.FormBloc>(context);
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocConsumer<form.FormBloc, form.FormState>(
              listener: (context, state) {
                if (state is form.FormValidateSuccess) {
                  save(todoBloc, state.taskName, state.taskDate);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is form.FormLoadSuccess) {
                  return TextFormField(
                    initialValue: state.taskName,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      errorText: state.error?.taskName,
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      formBloc.add(form.FormChanged(taskName: value));
                    },
                  );
                }

                return Container();
              },
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    formBloc.add(form.FormChanged(taskDate: date));
                  },
                  minTime: todo?.taskDate ?? DateTime.now(),
                  currentTime: todo?.taskDate ?? DateTime.now(),
                );
              },
              child: BlocBuilder<form.FormBloc, form.FormState>(
                builder: (context, state) {
                  if (state is form.FormLoadSuccess) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date & Time',
                        errorText: state.error?.taskDate,
                      ),
                      isEmpty: state.taskDate == null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(state.taskDate != null
                                  ? formatDate(state.taskDate!)
                                  : '')),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text('Cancel'),
                )),
                SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    formBloc.add(form.FormValidate());
                  },
                  child: Text('Save'),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
