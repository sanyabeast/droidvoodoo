// created by @sanyabeast, 2023, Ukraine

import 'package:droidvoodoo/features/app_main.dart';
import 'package:droidvoodoo/helpers.dart';

class IHaveLifecycle {
  bool _inited = false;
  // ignore: unused_field
  late int _initTime;
  late int id;

  init() async {
    if (!_inited) {
      _inited = true;
      id = generateId();
      await onInit();
      return;
    } else {
      return;
    }
  }

  start() => onStart();
  onStart() {}

  onInit() async {}
  update(double deviation, double delta) => onUpdate(deviation, delta);
  void onUpdate(double deviation, double delta) {}

  afterUpdate() => onAfterUpdate();
  void onAfterUpdate() {}

  dispose() => onDispose();
  void onDispose() {}
}

class AppComponent with IHaveLifecycle {
  final AppMainViewState appState;
  AppComponent({required this.appState});
}
