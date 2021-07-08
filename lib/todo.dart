import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  late final String id;
  final String taskName;
  final DateTime taskDate;
  final bool complete;

  Todo({
    String? id,
    required this.taskName,
    required this.taskDate,
    this.complete = false,
  }) : this.id = id ?? Uuid().v4();

  Todo copyWith({
    String? id,
    String? taskName,
    DateTime? taskDate,
    bool? complete,
  }) {
    return Todo(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDate: taskDate ?? this.taskDate,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object> get props => [id, taskName, taskDate, complete];

  @override
  String toString() {
    return 'Todo { id: $id, taskName: $taskName, taskDate: $taskDate, complete: $complete }';
  }
}
