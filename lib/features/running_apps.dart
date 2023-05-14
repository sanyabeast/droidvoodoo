import 'package:droidvoodoo/adb.dart';
import 'package:droidvoodoo/state.dart';
import 'package:flutter/material.dart';

class RunningAppsPage extends StatefulWidget {
  @override
  _RunningAppsPageState createState() => _RunningAppsPageState();
}

class _RunningAppsPageState extends State<RunningAppsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Running Apps'),
      ),
      body: ListView(
        children: [Text("test")],
      ),
    );
  }
}
