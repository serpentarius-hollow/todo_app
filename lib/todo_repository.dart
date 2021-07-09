import 'package:todo_app/todo_datasource.dart';

abstract class TodoRepository {
  Future<double?> getLatitude();
  Future<double?> getLongitude();
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
}
