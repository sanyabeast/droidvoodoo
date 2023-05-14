import 'package:droidvoodoo/core/component.dart';
import 'package:droidvoodoo/core/components/ticker.dart';
import 'package:droidvoodoo/features/device_info.dart';
import 'package:droidvoodoo/features/running_apps.dart';
import 'package:droidvoodoo/file_manager.dart';
import 'package:droidvoodoo/state.dart';
import 'package:flutter/material.dart';

class AppMainView extends StatefulWidget {
  const AppMainView({super.key});

  @override
  AppMainViewState createState() => AppMainViewState();
}

class AppMainViewState extends State<AppMainView> with TickerProviderStateMixin {
  /// core
  late List<IHaveLifecycle> components;
  late Ticker ticker;

  bool needsUpdate = true;

  /// gui
  String? _selectedItemKey;

  @override
  Widget build(BuildContext context) {
    var menuItems = {
      "File Manager": FileManagerPage(),
      "Running Apps": RunningAppsPage(),
      'Phone Info': DeviceInfoPage(),
    };

    return generateLayout(menuItems: menuItems);
  }

  @override
  void initState() {
    super.initState();
    ticker = Ticker(appState: this, onTick: onTick);
    components = [ticker];
    init();
  }

  init() async {
    await Future.forEach(components, (element) async {
      await element.init();
    });
    start();
    ticker.run();
  }

  start() {
    for (var element in components) {
      element.start();
    }
  }

  onTick(double deviation, double delta) {
    for (var element in components) {
      element.update(deviation, delta);
    }
    for (var element in components) {
      element.afterUpdate();
    }
    if (needsUpdate) {
      needsUpdate = false;
      setState(() {});
    }
  }

  generateLayout({required Map<String, Widget> menuItems}) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Droid Voodoo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (dvdState.deviceId != null)
                    Text(
                      dvdState.deviceInfo!['Device model']!,
                      style: TextStyle(fontSize: 32),
                    ),
                  if (dvdState.deviceId != null) Text(dvdState.deviceId!),
                  if (dvdState.deviceId == null) Text('disconnected'),
                ],
              )),
            ),
            ...menuItems.keys.map((key) {
              return ListTile(
                title: Text(key),
                onTap: () {
                  setState(() {
                    _selectedItemKey = key;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: _selectedItemKey == null
          ? Center(child: Text('Select an item from the menu.'))
          : menuItems[_selectedItemKey!],
    );
  }
}
