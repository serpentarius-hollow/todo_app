import 'package:location/location.dart';

import 'failure.dart';

class TodoDatasource {
  Future<LocationData> getLocation() async {
    final location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Failure('Location services are disabled');
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Failure('Location permissions are denied');
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}
