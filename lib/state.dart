import 'package:droidvoodoo/adb.dart';

class DroidVoodooState {
  List<String>? devices;
  String? deviceId;
  Map<String, String>? deviceInfo;

  init() async {
    devices = await getConnectedDevices();
    deviceId = devices!.isNotEmpty ? devices![0] : null;
    if (deviceId != null) {
      deviceInfo = await getDeviceInfo(deviceId!);
    }
  }
}

DroidVoodooState dvdState = DroidVoodooState();
