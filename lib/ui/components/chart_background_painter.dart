import 'package:flutter/material.dart';
import 'package:pushchino_app/ui/style/app_colors.dart';
import 'package:pushchino_app/ui/style/app_style.dart';

class ChartBackgroundPainter extends CustomPainter {
  const ChartBackgroundPainter({
    required this.linesCount,
  });
  final int linesCount;

  final double lineSpacing = 17;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withOpacity(0.4)
      ..strokeWidth = 1.0;

    final textStyle = AppStyle.fontStyle.copyWith(
      fontSize: 10,
    );

    for (int i = 0; i < linesCount; i++) {
      double yPosition = size.height - (i * lineSpacing);

      if (i == 0) {
        final cubeTextSpan = TextSpan(
          text: 'КУБ.',
          style: AppStyle.fontStyle.copyWith(fontSize: 10),
        );
        final cubeTextPainter = TextPainter(
          text: cubeTextSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        cubeTextPainter.layout();
        canvas.save();

        canvas.translate(-1, yPosition + 20);
        canvas.rotate(-1.5708);
        cubeTextPainter.paint(
          canvas,
          const Offset(-20, 0),
        );
        canvas.restore();
      }
      canvas.drawLine(
        Offset(10, yPosition),
        Offset(size.width, yPosition),
        paint,
      );
      final textSpan = TextSpan(text: '$i', style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: 50,
      );
      textPainter.paint(canvas, Offset(0, yPosition - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

