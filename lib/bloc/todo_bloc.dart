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
      yield* _mapTodoLoadedToState();
    }

    if (event is TodoAdded) {
      yield* _mapTodoAddedToState(currentState, event);
    }

    if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(currentState, event);
    }

    if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(currentState, event);
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(
    TodoState currentState,
    TodoDeleted event,
  ) async* {
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

  Stream<TodoState> _mapTodoUpdatedToState(
    TodoState currentState,
    TodoUpdated event,
  ) async* {
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

  Stream<TodoState> _mapTodoAddedToState(
    TodoState currentState,
    TodoAdded event,
  ) async* {
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

  Stream<TodoState> _mapTodoLoadedToState() async* {
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
}
