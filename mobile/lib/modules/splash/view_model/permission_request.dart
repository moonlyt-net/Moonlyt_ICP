import 'package:permission_handler/permission_handler.dart';

class PermissionViewModel {
  Future<bool> checkAndRequestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
      return status.isGranted;
    }
    return true;
  }
}