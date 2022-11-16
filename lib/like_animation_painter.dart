import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';

import 'like_animation_model.dart';

class LikeAnimationPainter extends CustomPainter {
  final List<LikeAnimationModel> likes;
  final double? sizeIcon;
  final Path? icon;
  final bool? hasOpacity;
  final bool? hasScale;

  LikeAnimationPainter({
    required this.likes,
    this.sizeIcon,
    this.icon,
    this.hasOpacity,
    this.hasScale,
  });

  Path drawStar(Size size) {
    final double width = size.width;
    final double height = size.height;
    final Path path = Path();
    path.moveTo(0.5 * width, height * 0.4);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.4);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var like in likes) {
      final progress = like.progress();
      final MultiTweenValues animation = like.tween.transform(progress);
      final double opacity = like.tweenOpacity.transform(progress);
      final position = Offset(
        animation.get<double>(OffsetProps.x) * size.width,
        animation.get<double>(OffsetProps.y) * size.height,
      );

      final rotationMatrix4 = Matrix4.identity()
        ..translate(position.dx, position.dy)
        ..rotateX(like.angleX)
        ..rotateY(like.angleY)
        ..rotateZ(like.angleZ);

      final mSizeIcon = sizeIcon ?? 24;
      final mScale = (hasScale ?? true) ? (opacity + 0.5) : 1.0;
      final mOpacity = (hasOpacity ?? true) ? opacity : 1.0;
      final mColor = like.color ?? Colors.red;
      final paint = Paint()
        ..color = mColor.withOpacity(mOpacity)
        ..style = PaintingStyle.fill;

      final finalPath =
          (icon ?? drawStar(Size(mSizeIcon * mScale, mSizeIcon * mScale)))
              .transform(rotationMatrix4.storage);
      canvas.drawPath(finalPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
