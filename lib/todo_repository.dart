import 'package:todo_app/database.dart';
import 'package:todo_app/todo_datasource.dart';

import 'failure.dart';
import 'todo.dart';

abstract class TodoRepository {
  Future<double?> getLatitude();
  Future<double?> getLongitude();
  Future<List<Todo>> selectAllTodos();
  Future insertTodo(Todo todo);
  Future updateTodo(Todo todo);
  Future deleteTodo(Todo todo);
}

class TodoRepositoryImplementation extends TodoRepository {
  final TodoDatasource _datasource;

  TodoRepositoryImplementation(this._datasource);

  @override
  Future<double?> getLatitude() async {
    final loc = await _datasource.getLocation();

    return loc.latitude;
  }

  @override
  Future<double?> getLongitude() async {
    final loc = await _datasource.getLocation();

    return loc.longitude;
  }

  @override
  Future<List<Todo>> selectAllTodos() async {
    try {
      final temp = await _datasource.db.allTodoEntries;

      final result = temp
          .map((e) => Todo(
                id: e.id,
                taskName: e.taskName,
                taskDate: e.taskDate,
                latitude: e.latitude,
                longitude: e.longitude,
                complete: e.complete,
              ))
          .toList();

      return result;
    } catch (_) {
      throw Failure('Failed to get the data');
    }
  }

  @override
  Future insertTodo(Todo todo) {
    try {
      final entry = TodoEntry(
        id: todo.id,
        taskName: todo.taskName,
        taskDate: todo.taskDate,
        latitude: todo.latitude,
        longitude: todo.longitude,
        complete: todo.complete,
      );

      return _datasource.db.addTodoEntry(entry);
    } catch (_) {
      throw Failure('Failed to add the data');
    }
  }

  @override
  Future updateTodo(Todo todo) {
    try {
      final entry = TodoEntry(
        id: todo.id,
        taskName: todo.taskName,
        taskDate: todo.taskDate,
        latitude: todo.latitude,
        longitude: todo.longitude,
        complete: todo.complete,
      );

      return _datasource.db.updateTodoEntry(entry);
    } catch (_) {
      throw Failure('Failed to update the data');
    }
  }

  @override
  Future deleteTodo(Todo todo) {
    try {
      final entry = TodoEntry(
        id: todo.id,
        taskName: todo.taskName,
        taskDate: todo.taskDate,
        latitude: todo.latitude,
        longitude: todo.longitude,
        complete: todo.complete,
      );

      return _datasource.db.deleteTodoEntry(entry);
    } catch (_) {
      throw Failure('Failed to delete the data');
    }
  }
}
