import 'package:flutter/material.dart';
import 'package:test_app/services/service_locator.dart';
import 'package:test_app/pages/timer/timer_page_logic.dart';


class TimerPage extends StatefulWidget {
  const TimerPage({
    super.key,
  });

  @override
  State<TimerPage> createState() => _TimerPageState();
}


class _TimerPageState extends State<TimerPage> {

  // Service injection.
  final stateManager = getIt<TimerPageManager>();

  @override
  void initState() {
    stateManager.initTimerState();
    super.initState();
  }

  @override
  void dispose() {
    stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            TimerText(),
            SizedBox(height: 20),
            ButtonsRow(),
          ],
        ),
      ),
    );
  }
}


class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stateManager = getIt<TimerPageManager>();

    return ValueListenableBuilder(
      valueListenable: stateManager.timeLeftNotifier,
      builder: (context, timeLeft, child) {
        return Text(
          timeLeft,
          style: Theme.of(context).textTheme.headlineMedium,
        );
      }
    );
  }
}


class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stateManager = getIt<TimerPageManager>();

    return ValueListenableBuilder(
      valueListenable: stateManager.buttonNotifier,
      builder: (BuildContext context, ButtonState buttonState, Widget? child) {
        return _buildButtonRow(buttonState);
      }
    );
  }

  Row _buildButtonRow(ButtonState buttonState) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (buttonState == ButtonState.initial) ...[
            StartButton(),
          ],
          if (buttonState == ButtonState.started) ...[
            PauseButton(),
            SizedBox(width: 20),
            ResetButton(),
          ],
          if (buttonState == ButtonState.paused) ...[
            StartButton(),
            SizedBox(width: 20),
            ResetButton(),
          ],
          if (buttonState == ButtonState.finished) ...[
            ResetButton(),
          ],
        ]
      );
  }
}


class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.start();
      },
      child: Icon(Icons.play_arrow),
    );
  }
}


class PauseButton extends StatelessWidget {
  const PauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.pause();
      },
      child: Icon(Icons.pause),
    );
  }
}


class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.reset();
      },
      child: Icon(Icons.replay),
    );
  }
}
