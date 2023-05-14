import 'dart:io';

Future<String> runAdbCommand(String deviceId, String command) async {
  final result = await Process.run('adb', ['-s', deviceId, 'shell', command]);
  return result.stdout as String;
}

Future<List<String>> getConnectedDevices() async {
  final result = await Process.run('adb', ['devices', '-l']);
  final output = result.stdout as String;

  final lines = output.split('\n');
  final deviceLines = lines.skip(1).where((line) => line.isNotEmpty);

  final deviceIds = deviceLines.map((line) {
    return line.split(' ').first;
  }).toList();

  return deviceIds;
}

Future<Map<String, String>> getDeviceInfo(String deviceId) async {
  final deviceModel = await runAdbCommand(deviceId, 'getprop ro.product.model');
  final androidVersion = await runAdbCommand(deviceId, 'getprop ro.build.version.release');
  final sdkVersion = await runAdbCommand(deviceId, 'getprop ro.build.version.sdk');
  final manufacturer = await runAdbCommand(deviceId, 'getprop ro.product.manufacturer');
  final battery = await runAdbCommand(deviceId, 'dumpsys battery | grep level');
  final screenSize = await runAdbCommand(deviceId, 'wm size');
  final screenDensity = await runAdbCommand(deviceId, 'wm density');

  return {
    'Device model': deviceModel.trim(),
    'Android version': androidVersion.trim(),
    'SDK version': sdkVersion.trim(),
    'Device manufacturer': manufacturer.trim(),
    'Device serial number': deviceId,
    'Battery level': battery.trim().split(": ")[1],
    'Screen resolution': screenSize.trim().split(": ")[1],
    'Screen density': screenDensity.trim().split(": ")[1],
  };
}

Future<List<String>> getRunningApps() async {
  final result = await Process.run('adb', ['shell', 'dumpsys', 'activity', 'activities']);
  final output = result.stdout as String;
  final lines = output.split('\n');

  final runningApps = <String>[];

  for (final line in lines) {
    if (line.contains('Hist #')) {
      final match =
          RegExp(r'[ ]*Hist #[0-9]+: ActivityRecord{[^ ]* [^ ]* ([^ ]*) .*').firstMatch(line);
      if (match != null && match.groupCount > 0) {
        runningApps.add(match.group(1)!);
      }
    }
  }

  return runningApps;
}
