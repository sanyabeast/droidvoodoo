import 'package:droidvoodoo/features/device_info.dart';
import 'package:droidvoodoo/file_manager.dart';
import 'package:droidvoodoo/state.dart';
import 'package:droidvoodoo/features/app_main.dart';
import 'package:flutter/material.dart';

void main() async {
  await dvdState.init();
  runApp(DroidVoodoo());
}

class DroidVoodoo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droid Voodoo',
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true, brightness: Brightness.dark),
      home: AppMainPage(title: 'Droid Voodoo Home Page'),
    );
  }
}

class AppMainPage extends StatelessWidget {
  final String title;

  const AppMainPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppMainView();
  }
}
