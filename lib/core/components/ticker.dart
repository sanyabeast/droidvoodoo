// created by @sanyabeast, 2023, Ukraine

import 'package:droidvoodoo/core/component.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

const double idealTickInterval = 1 / 60;

class Ticker extends AppComponent {
  late AnimationController _controller;
  late void Function(double deviation, double delta) onTick;
  int prevTickDate = DateTime.now().millisecondsSinceEpoch;
  bool running = false;

  Ticker({required super.appState, required this.onTick});
  @override
  onInit() {
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: appState)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      })
      ..addListener(() {
        if (running) {
          int now = DateTime.now().millisecondsSinceEpoch;
          double delta = now.toDouble() - prevTickDate.toDouble();
          delta /= 1000;
          onTick(delta / idealTickInterval, delta);
          prevTickDate = now;
        }
      });
  }

  run() {
    running = true;
  }

  stop() {
    running = false;
  }

  @override
  void onDispose() {
    _controller.dispose();
  }
}
