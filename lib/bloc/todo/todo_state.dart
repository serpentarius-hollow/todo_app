part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  const TodoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodoLoadFailure extends TodoState {
  final String message;

  const TodoLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class TodoAddedSuccess extends TodoState {
  final Todo todo;

  TodoAddedSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoUpdatedSuccess extends TodoState {
  final Todo todo;

  TodoUpdatedSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoDeletedSuccess extends TodoState {
  final Todo todo;

  TodoDeletedSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}
