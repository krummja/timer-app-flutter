import 'dart:async';
import 'package:flutter/foundation.dart';
import 'notifiers/time_left_notifier.dart';


class TimerPageManager {
  final timeLeftNotifier = TimeLeftNotifier();
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.initial);

  void initTimerState() {
    timeLeftNotifier.initialize();
  }

  void start() {
    if (buttonNotifier.value == ButtonState.paused) {
      _unpauseTimer();
    } else {
      _startTimer();
    }
  }

  void pause() {
    timeLeftNotifier.pause();
    buttonNotifier.value = ButtonState.paused;
  }

  void reset() {
    timeLeftNotifier.reset();
    buttonNotifier.value = ButtonState.initial;
  }

  void dispose() {
    timeLeftNotifier.dispose();
  }

  void _startTimer() {
    buttonNotifier.value = ButtonState.started;
    timeLeftNotifier.start(onDone: () {
      buttonNotifier.value = ButtonState.finished;
    });
  }

  void _unpauseTimer() {
    buttonNotifier.value = ButtonState.started;
    timeLeftNotifier.unpause();
  }
}


enum ButtonState {
  initial,
  started,
  paused,
  finished,
}
