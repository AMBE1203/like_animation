import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';

import 'like_animation_model.dart';
import 'like_animation_painter.dart';

enum LikeAnimationSpeed { fast, normal, slow }

class LikeAnimationWidget extends StatefulWidget {
  const LikeAnimationWidget({
    Key? key,
    this.colorOfIcon,
    this.hasOpacity,
    this.speed,
    this.sizeWidth,
    this.sizeHeight,
  }) : super(key: key);

  final List<Color>? colorOfIcon;
  final bool? hasOpacity;
  final LikeAnimationSpeed? speed;
  final double? sizeWidth;
  final double? sizeHeight;

  @override
  State<LikeAnimationWidget> createState() => _LikeAnimationWidgetState();
}

class _LikeAnimationWidgetState extends State<LikeAnimationWidget> {
  final Random random = Random();

  final List<LikeAnimationModel> likes = [];

  CustomPaint drawLikeIcon({required CustomPainter likePainter}) {
    return CustomPaint(
      foregroundPainter: likePainter,
      size: Size(widget.sizeWidth ?? 300, widget.sizeHeight ?? 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: LoopAnimation(
              tween: ConstantTween(1),
              builder: (context, child, value) {
                _removeLikeIcon();
                return drawLikeIcon(
                  likePainter: LikeAnimationPainter(likes: likes),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  likes.add(LikeAnimationModel(
                    random: random,
                    color: widget.colorOfIcon?[
                        random.nextInt(widget.colorOfIcon?.length ?? 0)],
                    speed: widget.speed ?? LikeAnimationSpeed.normal,
                  ));
                });
              },
              child: const Text("Click Me"))
        ],
      ),
    );
  }

  _removeLikeIcon() {
    likes.removeWhere((element) => element.checkIfLikeAnimationFinish());
  }
}
