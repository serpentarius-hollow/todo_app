import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../failure.dart';
import '../../todo.dart';
import '../../todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(TodoInitial());

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
        await _repository.deleteTodo(event.todo);

        final updatedTodos = currentState.todos
            .where((todo) => todo.id != event.todo.id)
            .toList();

        yield TodoDeletedSuccess(event.todo);
        yield TodoLoadSuccess(updatedTodos);
      } on Failure catch (err) {
        yield TodoLoadFailure(err.message);
        yield currentState;
      }
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(
    TodoState currentState,
    TodoUpdated event,
  ) async* {
    if (currentState is TodoLoadSuccess) {
      try {
        final latitude = await _repository.getLatitude();
        final longitude = await _repository.getLongitude();

        final todoUpdated = event.todo.copyWith(
          latitude: latitude,
          longitude: longitude,
        );

        await _repository.updateTodo(todoUpdated);

        final updatedTodos = currentState.todos.map((todo) {
          return todo.id == event.todo.id ? todoUpdated : todo;
        }).toList();

        yield TodoUpdatedSuccess(event.todo);
        yield TodoLoadSuccess(updatedTodos);
      } on Failure catch (err) {
        yield TodoLoadFailure(err.message);
        yield currentState;
      }
    }
  }

  Stream<TodoState> _mapTodoAddedToState(
    TodoState currentState,
    TodoAdded event,
  ) async* {
    if (currentState is TodoLoadSuccess) {
      try {
        final latitude = await _repository.getLatitude();
        final longitude = await _repository.getLongitude();

        final todoUpdated = event.todo.copyWith(
          latitude: latitude,
          longitude: longitude,
        );

        await _repository.insertTodo(todoUpdated);

        final updatedTodos = List<Todo>.from((state as TodoLoadSuccess).todos)
          ..add(todoUpdated);

        yield TodoAddedSuccess(event.todo);
        yield TodoLoadSuccess(updatedTodos);
      } on Failure catch (err) {
        yield TodoLoadFailure(err.message);
        yield currentState;
      }
    }
  }

  Stream<TodoState> _mapTodoLoadedToState() async* {
    try {
      final todos = await _repository.selectAllTodos();

      yield TodoLoadSuccess(todos);
    } catch (_) {
      yield TodoLoadFailure('Load Failure');
      yield TodoLoadSuccess();
    }
  }
}
