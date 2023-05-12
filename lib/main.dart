import 'package:droidvoodoo/file_manager.dart';
import 'package:droidvoodoo/device_info.dart';
import 'package:droidvoodoo/state.dart';
import 'package:droidvoodoo/widgets.dart';
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

  AppMainPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        menuItems: {"File Manager": FileManagerPage(), 'Phone Info': deviceInfoPage()});
  }
}
