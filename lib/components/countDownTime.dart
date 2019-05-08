import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final int seconds;
  final TextStyle textStyle;
  final VoidCallback endCallBack;

  CountDownTimer(
      {Key key, @required this.seconds, this.textStyle, this.endCallBack})
      : assert(seconds != null),
        super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

final _secondsDuration = Duration(seconds: 1);

class _CountDownTimerState extends State<CountDownTimer> {
  Timer _timer;
  Duration _duration;

  @override
  void initState() {
    super.initState();
    _timer?.cancel();
    _duration = Duration(seconds: widget.seconds);
    _timer = Timer.periodic(_secondsDuration, (time) {
      _duration = _duration - _secondsDuration;
      if (_duration.inSeconds == 0) {
        _timer?.cancel();
        if (widget.endCallBack != null) {
          widget.endCallBack();
        }
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  String _format(int num) {
    if (num > 10) {
      return num.toString();
    } else {
      return "0${num}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: _duration.inDays > 0 ? "${_duration.inDays}天" : "",
        children: [
          TextSpan(
              text: _format(_duration.inHours) +
                  ":" +
                  _format(_duration.inMinutes) +
                  ":" +
                  _format(_duration.inSeconds % 60)),
        ],
      ),
      style: widget.textStyle,
    );
  }
}
