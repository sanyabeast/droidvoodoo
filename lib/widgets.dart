import 'package:droidvoodoo/state.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatefulWidget {
  final Map<String, Widget> menuItems;

  CustomScaffold({required this.menuItems});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  String? _selectedItemKey;

  @override
  Widget build(BuildContext context) {
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
            ...widget.menuItems.keys.map((key) {
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
          : widget.menuItems[_selectedItemKey!],
    );
  }
}
