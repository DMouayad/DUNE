import 'dart:math';

import 'package:dune/presentation/screens/home/components/player_widgets/play_pause_button.dart';
import 'package:dune/presentation/screens/home/components/player_widgets/volume_controls.dart';
import 'package:dune/support/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

class Wheel extends StatefulWidget {
  const Wheel({super.key});

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox.square(
        dimension: constraints.maxHeight,
        child: GestureDetector(
          onPanUpdate: (details) =>
              panUpdateHandler(details, constraints.maxWidth / 2),
          onPanStart: (details) =>
              panStartHandler(details, constraints.maxWidth / 2),
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant.withOpacity(.8),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            // margin: const EdgeInsets.all(2),
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.background.withOpacity(.8),
                  ),
                  child: const PlayPauseButton(),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft, child: fastRewind(context)),
              Align(
                  alignment: Alignment.centerRight,
                  child: fastForward(context)),
              const Align(
                  alignment: Alignment.bottomCenter, child: VolumeControls()),
              // fastForward(context),
              // fastForward(context),
              // playButton(context)
            ]),
          ),
        ),
      );
    });
  }
}

bool wasExtraRadius = false;
final stopwatch =
    Stopwatch(); //On iPod, fast scrolling begins about 1-2 seconds after the start of scrolling
int oldTime = 0;
bool? previousDirection;
double volume = 0.0;
bool isVolume = false;
Timer? volumeTimer;
double cartesianStartX = 0.0;
double cartesianStartY = 0.0;
double cartesianStartRadius = 1.0;
int ticksPerCircle = 20;
double tickAngel = (2 * pi) / ticksPerCircle;

void setVolume(double value) {
  isVolume = true; // Volume is being changed

  volume = min(1.0, max(0, value));

  // Only perform haptic feedback if volume is neither 0 nor 1
  if (volume != 0.0 && volume != 1.0) {
    HapticFeedback.lightImpact();
  }

  // PerfectVolumeControl.setVolume(volume);

  // Cancel any existing timer
  volumeTimer?.cancel();

  // Start a new timer
  volumeTimer = Timer(const Duration(seconds: 1), () {
    isVolume = false; // Volume is no longer being changed
  });
}

double getVolume() {
  return volume;
}

void panUpdateHandler(DragUpdateDetails updateDetails, double halfSize) {
  final double cartesianCurX = halfSize - updateDetails.localPosition.dx;
  final double cartesianCurY = halfSize - updateDetails.localPosition.dy;

  final double radiusCur = sqrt(pow(cartesianCurX, 2) + pow(cartesianCurY, 2));

  if (testExtraRadius(radiusCur, halfSize)) return;
  if (wasExtraRadius) {
    setCartesianStart(updateDetails.localPosition.dx,
        updateDetails.localPosition.dy, halfSize);
    return;
  }

  final double cosTeta =
      (cartesianStartX * cartesianCurX + cartesianStartY * cartesianCurY) /
          (cartesianStartRadius * radiusCur);

  final double determinate =
      cartesianStartX * cartesianCurY - cartesianCurX * cartesianStartY;

  final double teta = acos(cosTeta) * (determinate > 0 ? 1.0 : -1.0);

  if (teta.abs() > tickAngel) {
    if (stopwatch.elapsedMilliseconds - 120 < oldTime) {
      if (!stopwatch.isRunning) stopwatch.start();
      oldTime = stopwatch.elapsedMilliseconds;
    } else {
      stopwatch.reset();
    }
    if (teta > 0) {
      scroll(false, stopwatch.elapsedMicroseconds);
      if (previousDirection == true) stopwatch.reset();
      previousDirection = false;

      // if (mainViewMode == MainViewMode.player) {
      //   setVolume(getVolume() + (1.0 / 16.0));
      // }

      // if (mainViewMode == MainViewMode.breakoutGame) {
      //   breakoutGame.currentState?.moveRight();
      //   HapticFeedback.lightImpact();
      // }
    } else if (teta < 0) {
      scroll(true, stopwatch.elapsedMicroseconds);
      if (previousDirection == false) stopwatch.reset();
      previousDirection = true;

      // if (mainViewMode == MainViewMode.player) {
      //   setVolume(getVolume() - (1.0 / 16.0));
      // }

      // if (mainViewMode == MainViewMode.breakoutGame) {
      //   breakoutGame.currentState?.moveLeft();
      //   HapticFeedback.lightImpact();
      // }
    }
    setCartesianStart(updateDetails.localPosition.dx,
        updateDetails.localPosition.dy, halfSize);
  }
}

void panStartHandler(DragStartDetails details, double halfSize) {
  setCartesianStart(
      details.localPosition.dx, details.localPosition.dy, halfSize);
}

void setCartesianStart(double x, double y, double halfSize) {
  cartesianStartX = halfSize - x;
  cartesianStartY = halfSize - y;
  cartesianStartRadius =
      sqrt(pow(cartesianStartX, 2) + pow(cartesianStartY, 2));
  testExtraRadius(cartesianStartRadius, halfSize);
}

bool testExtraRadius(double radius, double halfSize) {
  if (radius > halfSize || radius < 0.1 * halfSize) {
    wasExtraRadius = true;
  } else {
    wasExtraRadius = false;
  }
  return wasExtraRadius;
}

void scroll(bool up, int micros) {
  int count = (pow(2, (micros / 1000000).floor()) - 1).toInt();
  if (up) {
    // popUp
    //     ? altMenuKey?.currentState?.up(true)
    //     : menuKey?.currentState?.up(true);
  } else {
    // popUp
    //     ? altMenuKey?.currentState?.down(true)
    //     : menuKey?.currentState?.down(true);
  }

  for (int i = 0; i < count; i++) {
    if (up) {
      // popUp
      //     ? altMenuKey?.currentState?.up(false)
      //     : menuKey?.currentState?.up(false);
    } else {
      // popUp
      //     ? altMenuKey?.currentState?.down(false)
      //     : menuKey?.currentState?.down(false);
    }
  }
}

Widget menuButton(context) {
  return InkWell(
    onTap: () async {
      // if(mainViewMode != MainViewMode.menu) {
      //   homePressed(context);
      //   _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      // }
      // if(mainViewMode == MainViewMode.player) {
      //   setState(() {
      //     isCoverCycleVisible = true;
      //   });
      // }
      // else if(popUp == true) {
      //   setState(() {
      //     popUp = false;
      //   });
      // }
      // else {
      //
      //   menuKey.currentState?.back();
      //   _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      //
      //   if(isCoverCycleVisible == false /*&& isNestedMenu == true*/) {
      //     setState(() {
      //       isCoverCycleVisible = true;
      //     });
      //   }
      /*if(isCoverCycleVisible == false && isNestedMenu == false) {
            setState(() {
              isCoverCycleVisible = true;
            });
          }*/
      // }
      HapticFeedback.mediumImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      HapticFeedback.lightImpact();
    },
    child: Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 15),
      child: Text(
        'MENU',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.colorScheme.secondary.withOpacity(.7),
        ),
      ),
    ),
  );
}

Widget fastForward(BuildContext context) {
  Timer? timer;
  return GestureDetector(
      onLongPressStart: (details) {
        timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
          // musicControls.forward(context);
          HapticFeedback.selectionClick();
        });
      },
      onLongPressEnd: (details) {
        if (timer != null) {
          timer?.cancel();
          timer = null;
          print('hold ended');
          Future.delayed(const Duration(milliseconds: 100));
          HapticFeedback.lightImpact();
        }
      },
      child: IconButton(
          icon: Icon(
            Icons.fast_forward,
            color: context.colorScheme.secondary.withOpacity(.7),
          ),
          iconSize: 18,
          onPressed: () async {
            HapticFeedback.mediumImpact();
            // musicControls.playNextSong(context);
            await Future.delayed(const Duration(milliseconds: 100));
            HapticFeedback.lightImpact();
          })
      //margin: EdgeInsets.only(right: 30),
      );
}

Widget fastRewind(BuildContext context) {
  Timer? timer;
  return GestureDetector(
    onLongPressStart: (details) {
      timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        // musicControls.rewind(context);
        HapticFeedback.selectionClick();
      });
    },
    onLongPressEnd: (details) {
      if (timer != null) {
        timer?.cancel();
        timer = null;
        print('hold ended');
        Future.delayed(const Duration(milliseconds: 100));
        HapticFeedback.lightImpact();
      }
    },
    child: IconButton(
      icon: Icon(
        Icons.fast_rewind,
        color: context.colorScheme.secondary.withOpacity(.7),
      ),
      iconSize: 18,
      onPressed: () async {
        HapticFeedback.mediumImpact();
        // musicControls.playPrevSong(context);
        await Future.delayed(const Duration(milliseconds: 100));
        HapticFeedback.lightImpact();
      },
    ),
  );
}
