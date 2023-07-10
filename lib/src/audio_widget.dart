import 'package:flutter/material.dart';
import 'dart:ui';


class AudioWidget extends StatefulWidget
{
  const AudioWidget({
    super.key,
    this.isPlaying = false,
    required this.onPlayStateChanged,
    required this.currentTime,
    required this.onSeekBarMoved,
    required this.totalTime,
  });

  final bool isPlaying;
  final ValueChanged<bool> onPlayStateChanged;
  final Duration currentTime;
  final ValueChanged<Duration> onSeekBarMoved;
  final Duration totalTime;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}


class _AudioWidgetState extends State<AudioWidget>
{
  // State variables
  double _sliderValue = 0.0;
  bool _userIsMovingSlider = false;

  // State initializer
  @override
  void initState() {
    super.initState();
    _sliderValue = _getSliderValue();
    _userIsMovingSlider = false;
  }

  // Constructor
  @override
  Widget build(BuildContext context) {
    if (!_userIsMovingSlider) {
      _sliderValue = _getSliderValue();
    }

    return Row(
      children: [
        _buildPlayPauseButton(),
        _buildCurrentTimeLabel(),
        _buildSeekBar(context),
        _buildTotalTimeLabel(),
        SizedBox(width: 16),
      ],
    );
  }

  // Builders
  Text _buildTotalTimeLabel() {
    return Text(
      _getTimeString(1.0),
    );
  }

  Text _buildCurrentTimeLabel() {
    return Text(
      _getTimeString(_sliderValue),
      style: TextStyle(
        fontFeatures: const [
          FontFeature.tabularFigures()
        ],
      )
    );
  }

  Expanded _buildSeekBar(BuildContext context) {
    return Expanded(
      child: Slider(
        value: _sliderValue,
        activeColor: Theme.of(context).textTheme.bodySmall?.color,
        inactiveColor: Theme.of(context).disabledColor,
        // 1
        onChangeStart: (double value) {
          _userIsMovingSlider = true;
        },
        // 2
        onChanged: (double value) {
          setState(() {
            _sliderValue = value;
          });
        },
        // 3
        onChangeEnd: (double value) {
          _userIsMovingSlider = false;
          final currentTime = _getDuration(value);
          widget.onSeekBarMoved(currentTime);
        },
      ),
    );
  }

  IconButton _buildPlayPauseButton() {
    return IconButton(
        icon:
        (widget.isPlaying)
          ? Icon(Icons.pause)
          : Icon(Icons.play_arrow),
        color: Colors.black,
        onPressed: () {
          widget.onPlayStateChanged(!widget.isPlaying);
        },
      );
  }

  // Utility methods
  double _getSliderValue() {
    if (widget.currentTime == Duration()) {
      return 0;
    }

    double value = widget.currentTime.inMilliseconds / widget.totalTime.inMilliseconds;
    return value;
  }

  Duration _getDuration(double sliderValue) {
    final seconds = widget.totalTime.inSeconds * sliderValue;
    return Duration(seconds: seconds.toInt());
  }

  String _getTimeString(double sliderValue) {
    final time = _getDuration(sliderValue);

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final minutes = twoDigits(time.inMinutes.remainder(Duration.minutesPerHour));
    final seconds = twoDigits(time.inSeconds.remainder(Duration.secondsPerMinute));
    final hours = widget.totalTime.inHours > 0 ? '${time.inHours}:' : '';
    return "$hours$minutes:$seconds";
  }
}
