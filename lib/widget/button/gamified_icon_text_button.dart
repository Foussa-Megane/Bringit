import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/utils/button_level.dart';

class GamifiedIconTextButton extends StatefulWidget {
  GamifiedIconTextButton({
    Key? key,
    required this.title,
    required this.icon,
    this.level = ButtonLevel.unknown,
    required this.onPressed,
  }) : super(key: key);

  static double longPressDuration = 2000;

  final String title;
  final IconData icon;
  final ButtonLevel level;
  final GestureTapCallback onPressed;

  final Map<ButtonLevel, Color> colorByLevel = <ButtonLevel, Color>{
    ButtonLevel.unknown: NordColors.$0,
    ButtonLevel.careful: NordColors.$12,
    ButtonLevel.safe: NordColors.$14,
    ButtonLevel.risky: NordColors.$11,
  };

  @override
  State<GamifiedIconTextButton> createState() => _GamifiedIconTextButtonState();
}

class _GamifiedIconTextButtonState extends State<GamifiedIconTextButton> {
  late ButtonLevel defaultlevel = ButtonLevel.unknown;
  late Map<ButtonLevel, Color> buttonlevel;
  late ButtonLevel level = defaultlevel;
  late ButtonLevel state;
  Stopwatch animationStopWatch = Stopwatch();
  Timer animationRefreshTimer = Timer(const Duration(milliseconds: 1), () {});
  bool longPressAnimationRunning = true;

  double percent = 0;
  double elapsedTime = 0;
  int timeSoFar = 0;

  double millisecondsToPercentage(double time, double loadTime) {
    final double percent = (time * 100) / loadTime;
    return percent;
  }

  void refreshAnimation(Timer timer) {
    if (animationStopWatch.isRunning) {
      setState(() {
        longPressAnimationRunning = false;
        elapsedTime = animationStopWatch.elapsedMilliseconds.toDouble();
        percent = millisecondsToPercentage(
            elapsedTime, GamifiedIconTextButton.longPressDuration);
        if (elapsedTime >= GamifiedIconTextButton.longPressDuration) {
          stopLongPressAnimation();
        }
      });
    }
  }

  void beginLongPressAnimation() {
    longPressAnimationRunning = true;
    animationStopWatch.start();
    animationRefreshTimer =
        Timer.periodic(const Duration(milliseconds: 10), refreshAnimation);
  }

  void stopLongPressAnimation() {
    longPressAnimationRunning = false;
    animationStopWatch.stop();
    animationStopWatch.reset();
    setElapsedTime();
    longPressAnimationRunning = true;
    percent = 0;
  }

  void setElapsedTime() {
    final int timeSoFar = animationStopWatch.elapsedMilliseconds;
    setState(() {
      elapsedTime = timeSoFar.toDouble();
    });
  }

  @override
  void initState() {
    state = widget.level;
    buttonlevel = widget.colorByLevel;
    super.initState();
  }

  @override
  void dispose() {
    animationRefreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: InkWell(
        onTapDown: (_) {
          beginLongPressAnimation();
        },
        onTapUp: (_) {
          stopLongPressAnimation();
        },
        onHover: (_) {
          setState(() {
            level = state;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: buttonlevel[level],
              borderRadius: BorderRadius.circular(5),
              ),
          child:
            Row(
              children: <Widget>[
                Text(widget.title),
                const SizedBox(width: 5),
                Container(
                    height: 18,
                    width: 18,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: CircularProgressIndicator(
                            value:(level == ButtonLevel.risky? percent : 0) / 100.0,
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        Center(
                          child: Icon(
                            widget.icon,
                            size: 16,
                          ),
                        ),
                      ],
                    )),
              ],
            )
        ),
      ),
      onExit: (PointerExitEvent s) {
        setState(() {
          level = defaultlevel;
        });
      },
    );
  }
}
