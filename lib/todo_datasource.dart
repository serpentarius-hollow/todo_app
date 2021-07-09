import 'package:location/location.dart';
import 'package:todo_app/database.dart';

import 'failure.dart';

class TodoDatasource {
  final _db = AppDatabase();

  AppDatabase get db => _db;

  Future<LocationData> getLocation() async {
    final _location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        throw Failure('Location services are disabled');
      }
    }

    _permissionGranted = await _location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Failure('Location permissions are denied');
      }
    }

    _locationData = await _location.getLocation();

    return _locationData;
  }
}
