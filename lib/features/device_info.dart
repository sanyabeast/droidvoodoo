import 'package:droidvoodoo/adb.dart';
import 'package:droidvoodoo/state.dart';
import 'package:flutter/material.dart';

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  @override
  void initState() {
    if (dvdState.deviceInfo == null) {
      refresh();
    }
    super.initState();
  }

  refresh() async {
    if (dvdState.deviceId != null) {
      dvdState.deviceInfo = await getDeviceInfo(dvdState.deviceId!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dvdState.deviceInfo != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Phone Info'),
        ),
        body: ListView(
          children: [
            ...dvdState.deviceInfo!.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value),
              );
            }).toList(),
            ActionChip(
              label: Text('Refresh'),
              onPressed: refresh,
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Phone Info'),
        ),
        body: Center(
          child: Text('no device connected'),
        ),
      );
    }
  }
}
