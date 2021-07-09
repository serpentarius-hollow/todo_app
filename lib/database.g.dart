// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoEntry extends DataClass implements Insertable<TodoEntry> {
  final String id;
  final String taskName;
  final DateTime taskDate;
  final double? latitude;
  final double? longitude;
  final bool complete;
  TodoEntry(
      {required this.id,
      required this.taskName,
      required this.taskDate,
      this.latitude,
      this.longitude,
      required this.complete});
  factory TodoEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoEntry(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      taskName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_name'])!,
      taskDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}task_date'])!,
      latitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      longitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      complete: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}complete'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_name'] = Variable<String>(taskName);
    map['task_date'] = Variable<DateTime>(taskDate);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double?>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double?>(longitude);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  TodoEntriesCompanion toCompanion(bool nullToAbsent) {
    return TodoEntriesCompanion(
      id: Value(id),
      taskName: Value(taskName),
      taskDate: Value(taskDate),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      complete: Value(complete),
    );
  }

  factory TodoEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TodoEntry(
      id: serializer.fromJson<String>(json['id']),
      taskName: serializer.fromJson<String>(json['taskName']),
      taskDate: serializer.fromJson<DateTime>(json['taskDate']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskName': serializer.toJson<String>(taskName),
      'taskDate': serializer.toJson<DateTime>(taskDate),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  TodoEntry copyWith(
          {String? id,
          String? taskName,
          DateTime? taskDate,
          double? latitude,
          double? longitude,
          bool? complete}) =>
      TodoEntry(
        id: id ?? this.id,
        taskName: taskName ?? this.taskName,
        taskDate: taskDate ?? this.taskDate,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('TodoEntry(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('taskDate: $taskDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          taskName.hashCode,
          $mrjc(
              taskDate.hashCode,
              $mrjc(latitude.hashCode,
                  $mrjc(longitude.hashCode, complete.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoEntry &&
          other.id == this.id &&
          other.taskName == this.taskName &&
          other.taskDate == this.taskDate &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.complete == this.complete);
}

class TodoEntriesCompanion extends UpdateCompanion<TodoEntry> {
  final Value<String> id;
  final Value<String> taskName;
  final Value<DateTime> taskDate;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> complete;
  const TodoEntriesCompanion({
    this.id = const Value.absent(),
    this.taskName = const Value.absent(),
    this.taskDate = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.complete = const Value.absent(),
  });
  TodoEntriesCompanion.insert({
    required String id,
    required String taskName,
    required DateTime taskDate,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required bool complete,
  })  : id = Value(id),
        taskName = Value(taskName),
        taskDate = Value(taskDate),
        complete = Value(complete);
  static Insertable<TodoEntry> custom({
    Expression<String>? id,
    Expression<String>? taskName,
    Expression<DateTime>? taskDate,
    Expression<double?>? latitude,
    Expression<double?>? longitude,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskName != null) 'task_name': taskName,
      if (taskDate != null) 'task_date': taskDate,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (complete != null) 'complete': complete,
    });
  }

  TodoEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskName,
      Value<DateTime>? taskDate,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<bool>? complete}) {
    return TodoEntriesCompanion(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDate: taskDate ?? this.taskDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskName.present) {
      map['task_name'] = Variable<String>(taskName.value);
    }
    if (taskDate.present) {
      map['task_date'] = Variable<DateTime>(taskDate.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double?>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double?>(longitude.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoEntriesCompanion(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('taskDate: $taskDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $TodoEntriesTable extends TodoEntries
    with TableInfo<$TodoEntriesTable, TodoEntry> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodoEntriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _taskNameMeta = const VerificationMeta('taskName');
  late final GeneratedColumn<String?> taskName = GeneratedColumn<String?>(
      'task_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _taskDateMeta = const VerificationMeta('taskDate');
  late final GeneratedColumn<DateTime?> taskDate = GeneratedColumn<DateTime?>(
      'task_date', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  late final GeneratedColumn<double?> latitude = GeneratedColumn<double?>(
      'latitude', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  late final GeneratedColumn<double?> longitude = GeneratedColumn<double?>(
      'longitude', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _completeMeta = const VerificationMeta('complete');
  late final GeneratedColumn<bool?> complete = GeneratedColumn<bool?>(
      'complete', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (complete IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskName, taskDate, latitude, longitude, complete];
  @override
  String get aliasedName => _alias ?? 'todo_entries';
  @override
  String get actualTableName => 'todo_entries';
  @override
  VerificationContext validateIntegrity(Insertable<TodoEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_name')) {
      context.handle(_taskNameMeta,
          taskName.isAcceptableOrUnknown(data['task_name']!, _taskNameMeta));
    } else if (isInserting) {
      context.missing(_taskNameMeta);
    }
    if (data.containsKey('task_date')) {
      context.handle(_taskDateMeta,
          taskDate.isAcceptableOrUnknown(data['task_date']!, _taskDateMeta));
    } else if (isInserting) {
      context.missing(_taskDateMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    } else if (isInserting) {
      context.missing(_completeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoEntry.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoEntriesTable createAlias(String alias) {
    return $TodoEntriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoEntriesTable todoEntries = $TodoEntriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoEntries];
}
