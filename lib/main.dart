import 'package:flutter/material.dart';
import 'services/service_locator.dart';
import 'pages/timer/timer_page.dart';

void main() {
  setupGetIt();
  runApp(const AppRoot());
}


class AppRoot extends StatelessWidget {
  const AppRoot({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}
