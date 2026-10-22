import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EyewearFrameStyle {
  classicSquare,
  aviator,
  roundVintage,
  sunglassesSmoke,
}

class EyewearFrameGraphic extends StatelessWidget {
  final EyewearFrameStyle style;
  final double size;
  final String? badgeText;

  const EyewearFrameGraphic({
    super.key,
    required this.style,
    this.size = 64,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    Color frameColor;
    Color lensTintStart;
    Color lensTintEnd;

    switch (style) {
      case EyewearFrameStyle.classicSquare:
        frameColor = const Color(0xFF1E293B);
        lensTintStart = const Color(0xFFE2E8F0).withValues(alpha: 0.6);
        lensTintEnd = const Color(0xFF93C5FD).withValues(alpha: 0.35);
        break;
      case EyewearFrameStyle.aviator:
        frameColor = const Color(0xFFD97706); // Gold tone
        lensTintStart = const Color(0xFF78350F).withValues(alpha: 0.7);
        lensTintEnd = const Color(0xFFF59E0B).withValues(alpha: 0.3);
        break;
      case EyewearFrameStyle.roundVintage:
        frameColor = const Color(0xFF475569);
        lensTintStart = const Color(0xFFF1F5F9).withValues(alpha: 0.5);
        lensTintEnd = const Color(0xFFCBD5E1).withValues(alpha: 0.2);
        break;
      case EyewearFrameStyle.sunglassesSmoke:
        frameColor = const Color(0xFF0F172A);
        lensTintStart = const Color(0xFF1E293B).withValues(alpha: 0.85);
        lensTintEnd = const Color(0xFF475569).withValues(alpha: 0.5);
        break;
    }

    return SizedBox(
      width: size.w * 1.5,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft glow
          Container(
            width: size.w * 1.3,
            height: size.w * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: frameColor.withValues(alpha: 0.08),
            ),
          ),
          CustomPaint(
            size: Size(size.w * 1.35, size.w * 0.68),
            painter: _EyewearPainter(
              style: style,
              frameColor: frameColor,
              lensTintStart: lensTintStart,
              lensTintEnd: lensTintEnd,
            ),
          ),
        ],
      ),
    );
  }
}

class _EyewearPainter extends CustomPainter {
  final EyewearFrameStyle style;
  final Color frameColor;
  final Color lensTintStart;
  final Color lensTintEnd;

  _EyewearPainter({
    required this.style,
    required this.frameColor,
    required this.lensTintStart,
    required this.lensTintEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double lensW = w * 0.42;
    final double lensH = h * 0.76;
    final double top = (h - lensH) / 2;
    final double leftLensX = w * 0.04;
    final double rightLensX = w * 0.54;

    final framePaint = Paint()
      ..color = frameColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = (style == EyewearFrameStyle.aviator ? 2.0 : 3.0)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final lensShader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [lensTintStart, lensTintEnd],
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final lensFillPaint = Paint()
      ..shader = lensShader
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final glarePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    if (style == EyewearFrameStyle.roundVintage) {
      // Draw round lenses
      final leftCenter = Offset(leftLensX + lensW / 2, top + lensH / 2);
      final rightCenter = Offset(rightLensX + lensW / 2, top + lensH / 2);
      final radius = lensH / 2;

      canvas.drawCircle(leftCenter, radius, lensFillPaint);
      canvas.drawCircle(rightCenter, radius, lensFillPaint);
      canvas.drawCircle(leftCenter, radius, framePaint);
      canvas.drawCircle(rightCenter, radius, framePaint);

      // Bridge
      final bridgePath = Path()
        ..moveTo(leftCenter.dx + radius - 2, leftCenter.dy - 4)
        ..quadraticBezierTo(w * 0.5, leftCenter.dy - 12, rightCenter.dx - radius + 2, rightCenter.dy - 4);
      canvas.drawPath(bridgePath, framePaint);

      // Temples
      canvas.drawLine(Offset(leftCenter.dx - radius, leftCenter.dy - 4), Offset(0, leftCenter.dy - 7), framePaint);
      canvas.drawLine(Offset(rightCenter.dx + radius, rightCenter.dy - 4), Offset(w, rightCenter.dy - 7), framePaint);

      // Glare
      canvas.drawLine(Offset(leftCenter.dx - 8, leftCenter.dy - 10), Offset(leftCenter.dx + 4, leftCenter.dy - 14), glarePaint);
      canvas.drawLine(Offset(rightCenter.dx - 8, rightCenter.dy - 10), Offset(rightCenter.dx + 4, rightCenter.dy - 14), glarePaint);
    } else {
      // Rounded rectangles / Aviator shape
      final rRectRadius = Radius.circular(style == EyewearFrameStyle.aviator ? 18.0 : 10.0);
      final leftRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(leftLensX, top, lensW, lensH),
        rRectRadius,
      );
      final rightRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(rightLensX, top, lensW, lensH),
        rRectRadius,
      );

      canvas.drawRRect(leftRRect, lensFillPaint);
      canvas.drawRRect(rightRRect, lensFillPaint);
      canvas.drawRRect(leftRRect, framePaint);
      canvas.drawRRect(rightRRect, framePaint);

      // Nose bridge
      canvas.drawLine(
        Offset(leftLensX + lensW, top + lensH * 0.35),
        Offset(rightLensX, top + lensH * 0.35),
        framePaint,
      );

      if (style == EyewearFrameStyle.aviator) {
        // Aviator top bar
        canvas.drawLine(
          Offset(leftLensX + lensW * 0.3, top + 2),
          Offset(rightLensX + lensW * 0.7, top + 2),
          framePaint..strokeWidth = 1.8,
        );
      }

      // Temple hinges
      canvas.drawLine(Offset(leftLensX, top + lensH * 0.2), Offset(0, top + lensH * 0.2 - 2), framePaint);
      canvas.drawLine(Offset(rightLensX + lensW, top + lensH * 0.2), Offset(w, top + lensH * 0.2 - 2), framePaint);

      // Subtle diagonal glare reflection
      canvas.drawLine(
        Offset(leftLensX + lensW * 0.2, top + 6),
        Offset(leftLensX + lensW * 0.65, top + lensH * 0.55),
        glarePaint,
      );
      canvas.drawLine(
        Offset(rightLensX + lensW * 0.2, top + 6),
        Offset(rightLensX + lensW * 0.65, top + lensH * 0.55),
        glarePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _EyewearPainter oldDelegate) {
    return oldDelegate.style != style || oldDelegate.frameColor != frameColor;
  }
}
