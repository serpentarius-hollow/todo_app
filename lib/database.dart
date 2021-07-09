import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';

part 'database.g.dart';

@DataClassName('TodoEntry')
class TodoEntries extends Table {
  TextColumn get id => text()();
  TextColumn get taskName => text()();
  DateTimeColumn get taskDate => dateTime()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get complete => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [TodoEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<List<TodoEntry>> get allTodoEntries => select(todoEntries).get();

  Future addTodoEntry(TodoEntry entry) => into(todoEntries).insert(entry);

  Future updateTodoEntry(TodoEntry entry) => update(todoEntries).replace(entry);

  Future deleteTodoEntry(TodoEntry entry) => delete(todoEntries).delete(entry);

  @override
  int get schemaVersion => 1;
}
