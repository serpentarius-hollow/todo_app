import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/form/form_bloc.dart';
import 'bloc/notification/notification_bloc.dart';
import 'bloc/todo/todo_bloc.dart';
import 'todo.dart';
import 'todo_form.dart';

String formatDate(DateTime date) {
  return DateFormat('EEEE, d MMMM @ hh:mm a').format(date);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TodoBloc>().add(TodoLoaded());
    context.read<NotificationBloc>().add(NotificationStarted());
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoLoadFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationScheduledSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: BlocBuilder<TodoBloc, TodoState>(
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
            onPressed: () => showDialog(
                  context: context,
                  builder: (_) => BlocProvider(
                    create: (context) => FormBloc(),
                    child: TodoForm(),
                  ),
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
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.taskName,
                    style: todo.complete
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  Text(
                    formatDate(todo.taskDate),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )),
              Checkbox(value: todo.complete, onChanged: onChanged)
            ],
          ),
        ),
      ),
    );
  }
}
