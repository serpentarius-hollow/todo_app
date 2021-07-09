import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  late final String id;
  final String taskName;
  final DateTime taskDate;
  final double? latitude;
  final double? longitude;
  final bool complete;

  Todo({
    String? id,
    required this.taskName,
    required this.taskDate,
    this.latitude,
    this.longitude,
    this.complete = false,
  }) : this.id = id ?? Uuid().v4();

  Todo copyWith({
    String? id,
    String? taskName,
    DateTime? taskDate,
    double? latitude,
    double? longitude,
    bool? complete,
  }) {
    return Todo(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDate: taskDate ?? this.taskDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object?> get props =>
      [id, taskName, taskDate, latitude, longitude, complete];

  @override
  String toString() {
    return 'Todo { id: $id, taskName: $taskName, taskDate: $taskDate, latitude: $latitude, longitude: $longitude, complete: $complete }';
  }
}
