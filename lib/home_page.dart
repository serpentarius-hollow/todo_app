import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'bloc/todo_bloc.dart';
import 'todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TodoBloc>().add(TodoLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoadFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is TodoLoadSuccess) {
            if (state.todos.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (_, index) {
                  return TodoCheckboxTile(
                    todo: state.todos[index],
                    onChanged: (value) {
                      todoBloc.add(TodoUpdated(
                        state.todos[index].copyWith(complete: value),
                      ));
                    },
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => TodoForm(todo: state.todos[index]),
                    ),
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: state.todos.length,
              );
            } else {
              return Center(
                child: Text('No Data'),
              );
            }
          }

          return Container();
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
            onPressed: () => showDialog(
                  context: context,
                  builder: (_) => TodoForm(),
                ),
            icon: Icon(Icons.add),
            label: Text('Add')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class TodoCheckboxTile extends StatelessWidget {
  final Todo todo;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  const TodoCheckboxTile({
    required this.todo,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: TextStyle(color: Colors.red[100]),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.delete,
              color: Colors.red[100],
            )
          ],
        ),
      ),
      onDismissed: (_) => context.read<TodoBloc>().add(TodoDeleted(todo)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                todo.taskName,
                style: todo.complete
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              )),
              Checkbox(value: todo.complete, onChanged: onChanged)
            ],
          ),
        ),
      ),
    );
  }
}

class TodoForm extends StatefulWidget {
  final Todo? todo;

  const TodoForm({this.todo});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  DateTime? taskDate;

  final ctrlName = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskDate = widget.todo?.taskDate;
    ctrlName.text = widget.todo?.taskName ?? '';
  }

  @override
  void dispose() {
    ctrlName.dispose();
    super.dispose();
  }

  void save(TodoBloc todoBloc, Todo? todo) {
    if (todo != null) {
      todoBloc.add(TodoUpdated(
        todo.copyWith(
          taskName: ctrlName.text,
          taskDate: taskDate,
        ),
      ));
    } else {
      todoBloc.add(TodoAdded(
        Todo(
          taskName: ctrlName.text,
          taskDate: taskDate!,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: ctrlName,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    setState(() {
                      taskDate = date;
                    });
                  },
                  minTime: taskDate ?? DateTime.now(),
                  currentTime: taskDate ?? DateTime.now(),
                );
              },
              child: InputDecorator(
                decoration: InputDecoration(labelText: 'Date & Time'),
                isEmpty: taskDate == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(taskDate != null
                            ? '${DateFormat('EEEE, d MMMM - hh:mm a').format(taskDate!)}'
                            : '')),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
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
                    save(todoBloc, widget.todo);
                    Navigator.pop(context);
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
