import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';

import 'helper.dart';
import 'like_animation_widget.dart';

enum OffsetProps { x, y }

class LikeAnimationModel {
  late MultiTween<OffsetProps> tween;
  late Tween<double> tweenOpacity;
  late Duration duration;
  late Duration startTime;

  final Color? color;
  final LikeAnimationSpeed? speed;
  final Random random;

  double get angleX => _aX;

  double get angleY => _aY;

  double get angleZ => _aZ;

  double _aX = 0;
  double _aVelocityX = Helper.randomize(-0.1, 0.1);
  double _aY = 0;
  double _aVelocityY = Helper.randomize(-0.1, 0.1);
  double _aZ = 0;
  double _aVelocityZ = Helper.randomize(-1, 1);
  final double _mass = Helper.randomize(1, 11);
  final _aAcceleration = 0.0001;

  LikeAnimationModel({
    required this.random,
    this.color,
    this.speed,
  }) {
    _restart();
  }

  _restart() {
    _aVelocityX += _aAcceleration / _mass;
    _aVelocityY += _aAcceleration / _mass;
    _aVelocityZ += _aAcceleration / _mass;
    _aX += _aVelocityX;
    _aY += _aVelocityY;
    _aZ += _aVelocityZ;

    const startPosition = Offset(
      0.4,
      1.0,
    );
    final endPosition = Offset(
      -0.2 + 1.4 * random.nextDouble(),
      -0.1,
    );

    tweenOpacity = Tween(begin: 1.0, end: 0.0);
    tween = MultiTween<OffsetProps>()
      ..add(
        OffsetProps.x,
        Tween(
          begin: startPosition.dx,
          end: endPosition.dx,
        ),
      )
      ..add(
        OffsetProps.y,
        Tween(
          begin: startPosition.dy,
          end: endPosition.dy,
        ),
      );

    duration = Duration(
          milliseconds: speed == LikeAnimationSpeed.fast
              ? 1500
              : speed == LikeAnimationSpeed.normal
                  ? 3000
                  : 6000,
        ) +
        Duration(
          milliseconds: random.nextInt(
            speed == LikeAnimationSpeed.fast
                ? 3000
                : speed == LikeAnimationSpeed.normal
                    ? 6000
                    : 12000,
          ),
        );

    startTime = Duration(
      milliseconds: DateTime.now().millisecondsSinceEpoch,
    );
  }

  bool checkIfLikeAnimationFinish() {
    return progress() == 1.0;
  }

  double progress() {
    return ((Duration(
                  milliseconds: DateTime.now().millisecondsSinceEpoch,
                ).inMicroseconds -
                startTime.inMicroseconds) /
            duration.inMicroseconds)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}
