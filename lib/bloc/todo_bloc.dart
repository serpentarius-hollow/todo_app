import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial());

  // TODO: save todos to repository
  // Future _saveTodos(List<Todo> todos) {
  //   throw Exception();
  // }

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    final currentState = state;

    if (event is TodoLoaded) {
      try {
        final todos = [
          Todo(taskName: 'Task 1', taskDate: DateTime.now()),
          Todo(taskName: 'Task 2', taskDate: DateTime.now()),
          Todo(taskName: 'Task 3', taskDate: DateTime.now()),
        ];
        yield TodoLoadSuccess(todos);
      } catch (_) {
        yield TodoLoadFailure('Load Failure');
      }
    }

    if (event is TodoAdded) {
      if (currentState is TodoLoadSuccess) {
        try {
          final updatedTodos = List<Todo>.from((state as TodoLoadSuccess).todos)
            ..add(event.todo);

          yield TodoLoadSuccess(updatedTodos);
          // _saveTodos(updatedTodos);
        } catch (_) {
          yield TodoLoadFailure('Add Failure');
        }
      }
    }

    if (event is TodoUpdated) {
      if (currentState is TodoLoadSuccess) {
        try {
          final updatedTodos = currentState.todos.map((todo) {
            return todo.id == event.todo.id ? event.todo : todo;
          }).toList();

          yield TodoLoadSuccess(updatedTodos);
          // _saveTodos(updatedTodos);
        } catch (_) {
          yield TodoLoadFailure('Update Failure');
        }
      }
    }

    if (event is TodoDeleted) {
      if (currentState is TodoLoadSuccess) {
        try {
          final updatedTodos = currentState.todos
              .where((todo) => todo.id != event.todo.id)
              .toList();
          yield TodoLoadSuccess(updatedTodos);
          // _saveTodos(updatedTodos);
        } catch (_) {
          yield TodoLoadFailure('Delete Failure');
        }
      }
    }
  }
}
